FROM node:lts-alpine3.17

# renovate: datasource=github-releases depName=github/safe-settings versioning=semver
ARG SAFE_SETTINGS_VERSION="2.0.24-rc.4"
ENV SAFE_SETTINGS_VERSION=${SAFE_SETTINGS_VERSION}

RUN apk add --no-cache \
    git

RUN git clone https://github.com/github/safe-settings.git --branch ${SAFE_SETTINGS_VERSION} --single-branch --depth 1 && \
    cd safe-settings && \
    npm install

WORKDIR /safe-settings

RUN npm run prod