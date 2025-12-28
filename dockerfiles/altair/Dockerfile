# Each image should declare its component versions as build args at the top
# Format: {COMPONENT}_VERSION="x.y.z" with standardized renovate comments

# renovate: datasource=docker depName=node
ARG NODE_VERSION="24.12.0"
# renovate: datasource=git-refs depName=altair-graphql/altair
ARG ALTAIR_VERSION="8.1.3"

# First stage: Clone the Altair repository
FROM alpine/git@sha256:d86f367afb53d022acc4377741e7334bc20add161bb10234272b91b459b4b7d8 AS repo
WORKDIR /altair
ARG ALTAIR_VERSION
RUN git clone --depth 1 --branch v${ALTAIR_VERSION} https://github.com/altair-graphql/altair.git .

# Build stage - following the official Dockerfile
FROM node:${NODE_VERSION}-alpine AS base

# Copy the source code from the cloned repository
COPY --from=repo /altair /usr/src/app
WORKDIR /usr/src/app

# Install dependencies as per official Dockerfile
RUN apk update && apk add --no-cache libc6-compat python3 make g++ py3-pip && rm -rf /var/cache/apk/*
RUN ln -sf python3 /usr/bin/python
ENV TURBO_TELEMETRY_DISABLED=1

# Install pnpm
RUN --mount=type=cache,target=/root/.npm \
    npm install -g pnpm@latest

# Install dependencies and build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store \
    pnpm install --frozen-lockfile

RUN pnpm turbo run build --filter=@altairgraphql/api...
RUN pnpm deploy --filter=@altairgraphql/api /app

ENV NODE_ENV=production
USER node

WORKDIR /app

ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG=stdout

ARG PORT=3000
ENV PORT=${PORT}

CMD ["pnpm", "run", "start:prod:in-docker"]
