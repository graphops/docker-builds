#!/usr/bin/env bash

set -ex -o pipefail


RESTORE_SNAPSHOT=${RESTORE_SNAPSHOT:-"false"}
RESTORE_SNAPSHOT=${RESTORE_SNAPSHOT,,}

if [[ "${RESTORE_SNAPSHOT}" = "true" ]]; then
  echo "Skipping snapshot restore"
  exit 0
fi

if [[ -z "$URL" ]]; then
  echo "No URL to download set"
  exit 1
fi

if [[ -z "$DIR" ]]; then
  echo "No mount directory set, please set DIR env var"
  exit 1
fi

TAR_ARGS=${TAR_ARGS-""}
SUBPATH=${SUBPATH-""}

RM_SUBPATH=${RM_SUBPATH:-"true"}
RM_SUBPATH=${RM_SUBPATH,,}

CHUNK_SIZE=${CHUNK_SIZE:-$((1000 * 1000 * 1000))}

WORK_DIR="${DIR}/._download"
CHUNKS_DIR="${DIR}/._download/chunks"
STAMP="${DIR}/._download.stamp"
PIPE="${WORK_DIR}/stream_pipe"

if [[ -f "${STAMP}" && "$(cat "${STAMP}")" = "${URL}"  ]]; then
  echo "Already restored, exiting"
  exit 0
else
  echo "Preparing to download ${URL}"
fi

if [[ -d "${DIR}/${SUBPATH}" && "${RM_SUBPATH}" = "true" ]]; then
  rm -rf "${DIR}/${SUBPATH}/.*"
fi

FILESIZE="$(curl -sI "$URL" | grep -i Content-Length | awk '{print $2}' | tr -dc '[:alnum:]' )"

NR_PARTS=$((FILESIZE / CHUNK_SIZE))
if ((FILESIZE % CHUNK_SIZE > 0)); then
  ((NR_PARTS++))
fi

function init {
  if [ -d "$WORK_DIR" ]; then
    rm -rf "${WORK_DIR}"
  fi

  mkdir -p "${CHUNKS_DIR}"

  mkfifo "${PIPE}"
}

function processChunk {
  filename=$1
  cat "$CHUNKS_DIR/$filename" >&4
  rm "$CHUNKS_DIR/$filename" > /dev/null 2>&1
}

function watchStream {
  local processedLastPart="false"
  inotifywait --quiet --monitor --inotify --event moved_to --format "%f" "$CHUNKS_DIR" | until [[ "$processedLastPart" = "true" ]]
  do
    read filename
    processChunk "$filename"
    processedPart="$(echo "$filename" | cut -d '.' -f 3)"
    if [ "$processedPart" -eq "$NR_PARTS" ]; then
      processedLastPart="true"
      exec 4>&-
      kill --signal SIGUSR1 $$
    fi
  done
}

function download {
  local startPos=0
  local partNr=0
  local partPath=$(mktemp -p "${WORK_DIR}" "snapshot-download-XXXXXXXXXXXXX.part")
  local finishedDownload="false"

  until [[ "$finishedDownload" = "true" ]];
  do
    set +e
    if wget --quiet --no-check-certificate -O - "$URL" --start-pos "${startPos}" | pv --quiet --stop-at-size --size "$CHUNK_SIZE" > "$partPath"; then
      finishedDownload="true"
    fi
    set -e
    local downloadedSize="$(stat -c%s "$partPath")"
    if [[ "$finishedDownload" = "true" || $(( downloadedSize == CHUNK_SIZE )) ]]; then
      partNr=$(( startPos / CHUNK_SIZE + 1))
      mv "$partPath" "$CHUNKS_DIR/snapshot-download.part.$partNr" > /dev/null
      startPos=$((startPos + CHUNK_SIZE))
    fi
  done
}

function triggerFinished {
  echo "Finished downloading, recording stamp"
  echo "${URL}" > "${STAMP}"
  kill $download_pid || true > /dev/null 2>&1
  kill $watch_pid || true  > /dev/null 2>&1
  kill $cat_pid || true  > /dev/null 2>&1
  echo "Cleaning up"
  rm -rf "${WORK_DIR}"
  exit 0
}

trap triggerFinished SIGUSR1

init

exec 3<>"$PIPE" 4>"$PIPE" 5<"$PIPE"
exec 3>&-

watchStream&
watch_pid=$!

download&
download_pid=$!

if [[ ! -d "${DIR}/${SUBPATH}" ]]; then
  mkdir -p "${DIR}/${SUBPATH}"
fi

cat <&5 | pv --size "$FILESIZE" --progress --eta --timer | tar --verbose --extract --file - --directory "${DIR}/${SUBPATH}" ${TAR_ARGS} &
cat_pid=$!

wait
