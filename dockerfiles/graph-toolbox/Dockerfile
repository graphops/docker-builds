# Each image should declare its component versions as build args at the top
# Format: {COMPONENT}_VERSION="x.y.z" with standardized renovate comments

# renovate: datasource=docker depName=rust
ARG RUST_VERSION="1"
# renovate: datasource=docker depName=graphprotocol/graph-node
ARG GRAPH_NODE_VERSION="0.32.0"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli
ARG INDEXER_CLI_VERSION="0.20.22"
# renovate: datasource=npm depName=@graphprotocol/graph-cli
ARG GRAPH_CLI_VERSION="0.58.0"

FROM graphprotocol/graph-node:${GRAPH_NODE_VERSION} as graphman-source

FROM rust:${RUST_VERSION}@sha256:8a4ca3ca75afbc97bcf5362e9a694fe049d15734fbbaf82b8b7e224616c1254b as runtime

ENV DEBIAN_FRONTEND=noninteractive
ARG NODE_MAJOR=18
ENV NODE_MAJOR=${NODE_MAJOR}

RUN apt-get -q update \
  && apt-get -q -y install --no-install-recommends \
    git \
    httpie \
    curl \
    jq \
    mc \
    nano \
    net-tools \
    wget \
    gcc g++ make \
    postgresql \
    postgresql-contrib \
    aria2 \
    dumb-init \
    ca-certificates \
    gnupg


RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install nodejs -y

RUN npm install --global yarn && \
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_CLI_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
