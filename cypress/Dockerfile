FROM cypress/browsers:node16.14.2-slim-chrome100-ff99-edge

LABEL description="Image used for running Cypress testing framework"

WORKDIR /app

RUN npm install -g cypress mysql pg \
                   mocha mocha-steps mochawesome mochawesome-merge \
                   mochawesome-report-generator \
                   cypress-eslint-preprocessor \
                   cypress-promise \
                   cypress-xpath \
                   eslint faker@5.5.3 fs-extra moment prettier dotenv \
                   lodash date-fns cypress-fail-fast

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info
