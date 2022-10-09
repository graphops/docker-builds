ARG GRAPH_NODE_VERSION="v0.27.0"
ARG INDEXER_VERSION="v0.20.3"

FROM graphprotocol/graph-node:${GRAPH_NODE_VERSION} as graphman-source

FROM ghcr.io/graphprotocol/indexer-cli:${INDEXER_VERSION} as runtime

USER root

RUN apt update && \
    apt install -y \
        nano \
        libpq5 \
        curl \
        wget \
        httpie \
        postgresql \
        postgresql-contrib \
        git \
        netcat \
        net-tools \
        aria2

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

RUN alias graphman='graphman --config /graphman-config/config.toml'