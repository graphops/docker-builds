# renovate: datasource=docker depName=graphprotocol/graph-node versioning=semver
ARG GRAPH_NODE_VERSION="v0.28.2"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli versioning=semver
ARG INDEXER_VERSION="v0.20.4"
# renovate: datasource=npm depName=@graphprotocol/graph-cli versioning=semver
ARG GRAPH_CLI_VERSION="v0.20.4"

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
    gcc g++ make \
    postgresql \
    postgresql-contrib \
    aria2 \
    dumb-init

RUN (curl -sL https://deb.nodesource.com/setup_20.x | bash -) && \
    apt-get install -y nodejs && \
    npm install --global yarn && \
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
