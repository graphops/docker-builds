FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

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
