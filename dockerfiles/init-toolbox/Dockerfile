FROM golang:1.22-alpine@sha256:1a478681b671001b7f029f94b5016aed984a23ad99c707f6a0ab6563860ae2f3

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
