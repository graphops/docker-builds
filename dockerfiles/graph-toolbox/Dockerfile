ARG GRAPH_NODE_VERSION="v0.27.0"
ARG INDEXER_VERSION="v0.20.3"

FROM graphprotocol/graph-node:${GRAPH_NODE_VERSION} as graphman-source

FROM rust:1 as runtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q update \
  && apt-get -q -y install --no-install-recommends \
    git \
    httpie \
    curl \
    jq \
    mc \
    nano \
    netcat \
    net-tools \
    wget \
    build-essential \
    postgresql \
    postgresql-contrib \
    aria2

RUN npm cache clean -f && \
    npm install -g n && \
    n stable

RUN yarn global add nan @graphprotocol/graph-cli @graphprotocol/indexer-cli@${INDEXER_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

ENTRYPOINT ["/bin/sleep", "infinity"]