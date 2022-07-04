#!/bin/bash

set -e

yarn install
cypress run --spec cypress/e2e/2-advanced-examples/actions.cy.js --browser chrome
