# renovate: datasource=docker depName=graphprotocol/graph-node versioning=semver
ARG GRAPH_NODE_VERSION="v0.33.0@sha256:11ae63286e8bb69d89a9663e496ef1ceed715621ba2b3502f338e77666ddb6b1"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli versioning=semver
ARG INDEXER_VERSION="0.21.4"
# renovate: datasource=npm depName=@graphprotocol/graph-cli versioning=semver
ARG GRAPH_CLI_VERSION="0.81.0"

ARG TARGET="x86_64-unknown-linux-gnu"

ARG NODE_MAJOR=18

FROM rust:1-bookworm@sha256:29fe4376919e25b7587a1063d7b521d9db735fc137d3cf30ae41eb326d209471 as graphman-build

ARG GRAPH_NODE_VERSION
ARG TARGET

RUN apt-get -q update \
  && apt-get -q -y install \
    git \
    cmake \
    protobuf-compiler \
    pkg-config \
    libssl-dev \
    libpq-dev \
    ca-certificates

RUN mkdir /src

WORKDIR /src

RUN git clone https://github.com/graphprotocol/graph-node.git

WORKDIR /src/graph-node

RUN git checkout $(echo ${GRAPH_NODE_VERSION} | cut -d '@' -f 1)

RUN cargo build --bin graphman --release --target ${TARGET}

FROM rust:1-slim-bookworm@sha256:e8e40c50bfb54c0a76218f480cc69783b908430de87b59619c1dca847fdbd753 as runtime

ARG INDEXER_VERSION
ARG GRAPH_CLI_VERSION
ARG NODE_MAJOR
ARG TARGET

ENV DEBIAN_FRONTEND=noninteractive
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
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-build /src/graph-node/target/${TARGET}/release/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
