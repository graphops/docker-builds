FROM golang:1.23-alpine@sha256:09742590377387b931261cbeb72ce56da1b0d750a27379f7385245b2b058b63a

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR {GOPATH:-/go}/src/temporalite
RUN apk add --no-cache git && \
    git clone https://github.com/temporalio/temporalite.git && \
    cd temporalite && \
    go build -o ${GOPATH:-/go}/bin/ ./cmd/temporalite

FROM alpine:3.20@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d
WORKDIR /

COPY --from=0 ${GOPATH:-/go}/bin/temporalite /

EXPOSE 7233
EXPOSE 8233

ENTRYPOINT ["/temporalite", "start"]