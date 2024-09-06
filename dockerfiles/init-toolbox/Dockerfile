FROM golang:1.23-alpine@sha256:436e2d978524b15498b98faa367553ba6c3655671226f500c72ceb7afb2ef0b1

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR /go/src/gnosischain/download-manager
RUN apk add --no-cache git && \
    git clone https://github.com/gnosischain/download-manager --depth=1 --branch=${DOWNLOAD_MANAGER_REF} . && \
    go get github.com/vbauerster/getparty && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o download-manager .

FROM alpine:3.20@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5
WORKDIR /
RUN apk add --no-cache curl aria2
COPY --from=0 /go/src/gnosischain/download-manager/download-manager /download-manager
