FROM golang:1.21-alpine@sha256:a429230abae5f23c968b45ffb8a8bc0bd8145921c80de8900357d8ead76a1b64

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR {GOPATH:-/go}/src/temporalite
RUN apk add --no-cache git && \
    git clone https://github.com/temporalio/temporalite.git && \
    cd temporalite && \
    go build -o ${GOPATH:-/go}/bin/ ./cmd/temporalite

FROM alpine:3.19@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48
WORKDIR /

COPY --from=0 ${GOPATH:-/go}/bin/temporalite /

EXPOSE 7233
EXPOSE 8233

ENTRYPOINT ["/temporalite", "start"]