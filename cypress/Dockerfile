# see build.yaml for actual version passed from pipeline
ARG NODE_VERSION="16.18.1"

FROM cypress/browsers:node-${NODE_VERSION}-chrome-110.0.5481.96-1-ff-109.0-edge-110.0.1587.41-1

LABEL description="Image used for running Cypress testing framework"

WORKDIR /app

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
