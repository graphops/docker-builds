# renovate: datasource=docker depName=rust
ARG RUST_VERSION="1"
# renovate: datasource=docker depName=graphprotocol/graph-node
ARG GRAPH_NODE_VERSION="v0.36.1"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli
ARG INDEXER_VERSION="0.22.0"
# renovate: datasource=npm depName=@graphprotocol/graph-cli
ARG GRAPH_CLI_VERSION="0.96.0"

ARG TARGET="x86_64-unknown-linux-gnu"

ARG NODE_MAJOR=22

FROM rust:${RUST_VERSION}-bookworm@sha256:ad7e5fd44a71f317c88993a64d4073f9050516cd420ddacd90b7d43829f29f26 as graphman-build

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

FROM rust:${RUST_VERSION}-slim-bookworm@sha256:c46b18afcf69c93b00781d3108addc0f5d5f113cd69faccb02e1c22b470e6b3d as runtime

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
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_CLI_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-build /src/graph-node/target/${TARGET}/release/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
