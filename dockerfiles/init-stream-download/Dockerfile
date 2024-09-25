FROM alpine:3.20@sha256:e72ad0747b9dc266fca31fb004580d316b6ae5b0fdbbb65f17bbe371a5b24cff

RUN apk add --no-cache \
  coreutils \
  bash \
  pv \
  wget \
  tar \
  curl \
  inotify-tools \
  dumb-init

COPY stream-download.sh /usr/local/bin/stream-download.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/bin/bash", "-c", "/usr/local/bin/stream-download.sh"]
