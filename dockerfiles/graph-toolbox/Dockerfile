# renovate: datasource=docker depName=rust
ARG RUST_VERSION="1"
# renovate: datasource=docker depName=graphprotocol/graph-node
ARG GRAPH_NODE_VERSION="v0.41.1"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli
ARG INDEXER_VERSION="0.24.3"
# renovate: datasource=npm depName=@graphprotocol/graph-cli
ARG GRAPH_CLI_VERSION="0.98.1"

ARG TARGET="x86_64-unknown-linux-gnu"

ARG NODE_MAJOR=22

FROM rust:${RUST_VERSION}-bookworm@sha256:af8fc166ddc0b7aa469f695dbb57c6f859dd440162dab6130d7e4714cbbf8dca as graphman-build

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

# Ensure the Rust toolchain is installed for the target architecture
RUN rustup target add ${TARGET} && rustup toolchain install stable-${TARGET}

RUN mkdir /src

WORKDIR /src

RUN git clone https://github.com/graphprotocol/graph-node.git

WORKDIR /src/graph-node

RUN git checkout $(echo ${GRAPH_NODE_VERSION} | cut -d '@' -f 1)

RUN cargo build --bin graphman --release --target ${TARGET}

FROM rust:${RUST_VERSION}-slim-bookworm@sha256:ea63277ad2e4d89ea2e2b170ab0bde8813ed4809f66afa3db596d1ccf90b5903 as runtime

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

# Ensure the Rust toolchain is installed for the target architecture
RUN rustup target add ${TARGET} && rustup toolchain install stable-${TARGET}

RUN npm install --global yarn && \
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_CLI_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-build /src/graph-node/target/${TARGET}/release/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
