ARG NODE_BASE="lts-alpine3.16"
FROM node:${NODE_BASE}

LABEL description="Image used for running Karma with ChromeHeadless browser. Requires the --no-sandbox flag to be specified to work."

ENV APK_DEPENDENCIES="bash curl git jq vim chromium zlib-dev xvfb dbus mesa-dri-swrast udev ttf-freefont python3 make g++" \
    CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"

WORKDIR /app

USER root

COPY ./version-info /usr/bin/

RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
  && chmod +x /usr/bin/version-info \
  && rm -rf ${PATHS_TO_REMOVE}
