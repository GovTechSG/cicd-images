# see build.yaml for actual version passed from pipeline
ARG NODE_BROWSER_VERSION="16.14.2-slim-chrome103-ff102"

FROM cypress/browsers:node${NODE_BROWSER_VERSION}

LABEL maintainer="ramesh_bask" \
      description="Image used for run Playwright testing framework"

RUN npm install -g playwright
RUN npx playwright install

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link $(ls -1 $(npm root -g)/)