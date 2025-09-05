FROM golang:1.25-alpine@sha256:b6ed3fd0452c0e9bcdef5597f29cc1418f61672e9d3a2f55bf02e7222c014abd

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR /go/src/gnosischain/download-manager
RUN apk add --no-cache git && \
    git clone https://github.com/gnosischain/download-manager --depth=1 --branch=${DOWNLOAD_MANAGER_REF} . && \
    go get github.com/vbauerster/getparty && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o download-manager .

FROM alpine:3.22@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1
WORKDIR /
RUN apk add --no-cache curl aria2 jq kubectl
COPY --from=0 /go/src/gnosischain/download-manager/download-manager /download-manager
