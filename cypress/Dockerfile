# see build.yaml for actual version passed from pipeline
ARG NODE_VERSION="16.18.1"

# set as the latest one, i don't include edge because ... meh
ARG CYPRESS_VERSION="13.6.3"
ARG CHROME_VERSION="120.0.6099.224-1"
ARG FIREFOX_VERSION="121.0.1"

FROM cypress/factory

LABEL description="Image used for running Cypress testing framework"

WORKDIR /app

# need to run this command, so to install the node version above and all the browsers 
RUN npm install --save-dev cypress

RUN apt update

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt install -y jq awscli libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libnss3 libxss1 libasound2 libxtst6 xauth xvfb

RUN npm install -g mysql pg \
                   mocha mocha-steps mochawesome mochawesome-merge \
                   mochawesome-report-generator \
                   cypress-eslint-preprocessor \
                   cypress-promise \
                   cypress-xpath \
                   eslint @faker-js/faker@5.5.3 fs-extra moment prettier dotenv \
                   lodash date-fns cypress-fail-fast axios glob js-yaml

# Install the purple-hats and its node dependencies - https://github.com/GovTechSG/purple-hats/blob/master/INTEGRATION.md
RUN npm install -g @govtechsg/purple-hats playwright
RUN npm install --prefix $(npm root -g)/@govtechsg/purple-hats

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info
