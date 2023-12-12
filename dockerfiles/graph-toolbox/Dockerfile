# renovate: datasource=docker depName=graphprotocol/graph-node versioning=semver
ARG GRAPH_NODE_VERSION="v0.33.0@sha256:11ae63286e8bb69d89a9663e496ef1ceed715621ba2b3502f338e77666ddb6b1"
# renovate: datasource=npm depName=@graphprotocol/indexer-cli versioning=semver
ARG INDEXER_VERSION="0.20.23"
# renovate: datasource=npm depName=@graphprotocol/graph-cli versioning=semver
ARG GRAPH_CLI_VERSION="0.63.0"

FROM graphprotocol/graph-node:${GRAPH_NODE_VERSION} as graphman-source

FROM rust:1-slim-bullseye@sha256:7c58e9fea791e63967d35375dc93f8e93bdaaf53e5f55862984bcf16bfe68fd7 as runtime

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
    yarn global add nan @graphprotocol/graph-cli@${GRAPH_CLI_VERSION} @graphprotocol/indexer-cli@${INDEXER_VERSION}

WORKDIR /workspace

ADD ./inner-readme README

COPY --from=graphman-source /usr/local/bin/graphman /usr/local/bin/graphman

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "/bin/sleep infinity"]
