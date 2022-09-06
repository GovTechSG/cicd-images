FROM pandoc/core:latest

LABEL maintainer="ramesh_bask" \
      description="Node-Pandoc container used to generate sprint review slides in CI pipeline"

RUN apk add yarn

COPY ./version-info /usr/bin
RUN chmod +x /usr/bin/version-info