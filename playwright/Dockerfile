# see build.yaml for actual version passed from pipeline
ARG NODE_VERSION="14.19.0"

FROM cypress/browsers:node${NODE_VERSION}-slim-chrome100-ff99-edge

LABEL maintainer="ramesh_bask" \
      description="Image used for running concurrent sessions tests using Playwright"

RUN npm install -g playwright
RUN npx playwright install

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link $(ls -1 $(npm root -g)/)