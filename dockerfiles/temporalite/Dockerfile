FROM golang:1.25-alpine@sha256:26111811bc967321e7b6f852e914d14bede324cd1accb7f81811929a6a57fea9

WORKDIR {GOPATH:-/go}/src/temporalite
RUN apk add --no-cache git && \
    git clone https://github.com/temporalio/temporalite.git && \
    cd temporalite && \
    go build -o ${GOPATH:-/go}/bin/ ./cmd/temporalite

FROM alpine:3.23@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375
WORKDIR /

COPY --from=0 ${GOPATH:-/go}/bin/temporalite /

EXPOSE 7233
EXPOSE 8233

ENTRYPOINT ["/temporalite", "start"]