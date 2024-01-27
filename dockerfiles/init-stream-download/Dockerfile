FROM alpine:3.19@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

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
