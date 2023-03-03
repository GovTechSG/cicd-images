# see build.yaml for actual version passed from pipeline
ARG NODE_VERSION="16.16.0"

FROM cypress/browsers:node${NODE_VERSION}-chrome107-ff107

LABEL description="Image used for running Cypress testing framework"

WORKDIR /app

RUN npm install -g cypress mysql pg \
                   mocha mocha-steps mochawesome mochawesome-merge \
                   mochawesome-report-generator \
                   cypress-eslint-preprocessor \
                   cypress-promise \
                   cypress-xpath \
                   eslint @faker-js/faker@5.5.3 fs-extra moment prettier dotenv \
                   lodash date-fns cypress-fail-fast axios glob js-yaml

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info
