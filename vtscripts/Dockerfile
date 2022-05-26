FROM alpine:3.15
LABEL maintainer="zephinzer <dev-at-joeir-dot-net>" \
      description="Version tagger container for use in CI pipelines"
ENV APK_DEPENDENCIES="bash curl git jq vim" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*" \
    PATH_PACKAGE="/vtscripts" \
    PATH_SYSTEM_BIN="/usr/local/bin" \
    GIT_CLONE_ADDRESS="https://github.com/GovTechSG/version-tagging-scripts.git"
WORKDIR /
USER root
COPY ./version-info /usr/bin
RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && chmod +x /usr/bin/version-info \
    && git clone -b master "${GIT_CLONE_ADDRESS}" "${PATH_PACKAGE}" \
    && ln -s ${PATH_PACKAGE}/get-branch ${PATH_SYSTEM_BIN}/get-branch \
    && ln -s ${PATH_PACKAGE}/get-latest ${PATH_SYSTEM_BIN}/get-latest \
    && ln -s ${PATH_PACKAGE}/get-next ${PATH_SYSTEM_BIN}/get-next \
    && ln -s ${PATH_PACKAGE}/init ${PATH_SYSTEM_BIN}/init \
    && ln -s ${PATH_PACKAGE}/iterate ${PATH_SYSTEM_BIN}/iterate \
    && rm -rf ${PATHS_TO_REMOVE}
