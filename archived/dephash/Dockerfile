FROM alpine:3.15
LABEL maintainer="zephinzer <dev-at-joeir-dot-net>" \
      description="Dependency hasher image for use in CI containers"
ENV APK_DEPENDENCIES="bash curl git jq vim" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      /var/cache/misc/*" \
    PATH_PACKAGE="/dephash" \
    PATH_SYSTEM_BIN="/usr/local/bin" \
    GIT_CLONE_ADDRESS="https://github.com/GovTechSG/dependency-hasher.git"
WORKDIR /app
USER root
COPY ./version-info /usr/bin
RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && chmod +x /usr/bin/version-info \
    && git clone -b master "${GIT_CLONE_ADDRESS}" "${PATH_PACKAGE}" \
    && ln -s ${PATH_PACKAGE}/dephash ${PATH_SYSTEM_BIN}/dephash \
    && rm -rf ${PATHS_TO_REMOVE}
