FROM  grafana/k6:latest
FROM node:latest

LABEL description="Image used for running k6 for load testing"

RUN npm install -g k6

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info