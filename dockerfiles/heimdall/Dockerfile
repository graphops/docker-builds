# renovate: datasource=github-releases depName=maticnetwork/heimdall
ARG HEIMDALL_VERSION="v1.0.3"

FROM golang:1.20-alpine AS builder

ARG HEIMDALL_VERSION

RUN apk add --no-cache \
    build-base \
    git \
    linux-headers \
    ca-certificates

# Clone and build Heimdall
RUN git clone https://github.com/maticnetwork/heimdall.git /heimdall && \
    cd /heimdall && \
    git checkout ${HEIMDALL_VERSION} && \
    make install

# Final image
FROM alpine:3.19

ARG HEIMDALL_DIR=/var/lib/heimdall
ENV HEIMDALL_DIR=${HEIMDALL_DIR}

# Install required packages including dumb-init for zombie process reaping
RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    jq \
    dumb-init

# Create Heimdall directory
RUN mkdir -p ${HEIMDALL_DIR}

# Copy binaries from builder
COPY --from=builder /go/bin/heimdalld /usr/local/bin/
COPY --from=builder /go/bin/heimdallcli /usr/local/bin/

# Create entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Use dumb-init as entrypoint to handle signals and reap zombie processes
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
