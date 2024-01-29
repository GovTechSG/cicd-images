FROM cypress/browsers:node14.15.0-chrome96-ff94

LABEL maintainer="ramesh_bask" \
      description="Image used for running concurrent sessions tests using Playwright"

RUN npm install -g playwright
RUN npx playwright install

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link $(ls -1 $(npm root -g)/)