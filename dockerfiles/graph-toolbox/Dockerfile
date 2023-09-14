# renovate: datasource=docker depName=graphprotocol/graph-node versioning=semver
ARG GRAPH_NODE_VERSION="v0.32.0@sha256:787665b2e82c915e407f9eb14ea59c78d840d05bf186a20d6e32a8a4b0b7a8c5"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli versioning=semver
ARG INDEXER_VERSION="0.20.22"
# renovate: datasource=npm depName=@graphprotocol/graph-cli versioning=semver
ARG GRAPH_CLI_VERSION="0.58.0"

FROM graphprotocol/graph-node:${GRAPH_NODE_VERSION} as graphman-source

FROM rust:1@sha256:8a4ca3ca75afbc97bcf5362e9a694fe049d15734fbbaf82b8b7e224616c1254b as runtime

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

RUN (curl -sL https://deb.nodesource.com/setup_18.x | bash -) && \
    apt-get install -y nodejs && \
    npm install --global yarn && \
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
