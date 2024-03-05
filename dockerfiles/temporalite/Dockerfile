FROM golang:1.22-alpine@sha256:fc5e5848529786cf1136563452b33d713d5c60b2c787f6b2a077fa6eeefd9114

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR {GOPATH:-/go}/src/temporalite
RUN apk add --no-cache git && \
    git clone https://github.com/temporalio/temporalite.git && \
    cd temporalite && \
    go build -o ${GOPATH:-/go}/bin/ ./cmd/temporalite

FROM alpine:3.19@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
WORKDIR /

COPY --from=0 ${GOPATH:-/go}/bin/temporalite /

EXPOSE 7233
EXPOSE 8233

ENTRYPOINT ["/temporalite", "start"]