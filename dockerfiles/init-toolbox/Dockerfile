FROM golang:1.22-alpine@sha256:fc5e5848529786cf1136563452b33d713d5c60b2c787f6b2a077fa6eeefd9114

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR /go/src/gnosischain/download-manager
RUN apk add --no-cache git && \
    git clone https://github.com/gnosischain/download-manager --depth=1 --branch=${DOWNLOAD_MANAGER_REF} . && \
    go get github.com/vbauerster/getparty && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o download-manager .

FROM alpine:3.19@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
WORKDIR /
RUN apk add --no-cache curl aria2
COPY --from=0 /go/src/gnosischain/download-manager/download-manager /download-manager
