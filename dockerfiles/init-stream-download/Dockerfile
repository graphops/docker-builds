FROM alpine:3.18@sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0

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
