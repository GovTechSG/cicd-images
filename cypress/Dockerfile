# see build.yaml for actual version passed from pipeline
ARG NODE_VERSION="set-from-argument"
FROM cypress/browsers:${NODE_VERSION}

LABEL description="Image used for running Cypress testing framework"

WORKDIR /app

RUN apt update

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt install -y jq awscli xvfb

RUN npm install -g cypress mysql pg \
                   mocha mocha-steps mochawesome mochawesome-merge \
                   mochawesome-report-generator \
                   cypress-eslint-preprocessor \
                   cypress-promise \
                   cypress-xpath \
                   eslint @faker-js/faker@5.5.3 fs-extra moment prettier dotenv \
                   lodash date-fns cypress-fail-fast axios glob js-yaml @govtechsg/purple-hats

# Install node dependencies for the purple-hats - https://github.com/GovTechSG/purple-hats/blob/master/INTEGRATION.md
RUN npm install --prefix $(npm root -g)/@govtechsg/purple-hats

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info
