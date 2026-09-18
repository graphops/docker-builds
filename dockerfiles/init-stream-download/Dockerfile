FROM alpine:3.24@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

RUN apk add --no-cache \
  coreutils \
  bash \
  pv \
  wget \
  lz4 \
  tar \
  curl \
  inotify-tools \
  dumb-init

COPY stream-download.sh /usr/local/bin/stream-download.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/bin/bash", "-c", "/usr/local/bin/stream-download.sh"]
