FROM golang:1.21-alpine@sha256:29fd37e32a229819bf9eb230c4577eb95f18982abeec1b521ae881e6ef251457

ENV DOWNLOAD_MANAGER_REF="main"

WORKDIR /go/src/gnosischain/download-manager
RUN apk add --no-cache git && \
    git clone https://github.com/gnosischain/download-manager --depth=1 --branch=${DOWNLOAD_MANAGER_REF} . && \
    go get github.com/vbauerster/getparty && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o download-manager .

FROM alpine:3.19@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48
WORKDIR /
RUN apk add --no-cache curl aria2
COPY --from=0 /go/src/gnosischain/download-manager/download-manager /download-manager
