ARG GRAPH_NODE_VERSION="v0.27.0"
ARG INDEXER_VERSION="v0.20.3"

FROM graphprotocol/graph-node:${GRAPH_NODE_VERSION} as graphman-source

FROM node:16-alpine3.16 as runtime

RUN apk add --no-cache \
        nano \
        curl \
        wget \
        httpie \
        postgresql \
        git \
        net-tools \
        aria2

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN source "$HOME/.cargo/env" && \
    yarn global add @graphprotocol/graph-cli && \
    yarn global add @graphprotocol/indexer-cli@${INDEXER_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

ENTRYPOINT [ "/bin/sleep", "infinity" ]