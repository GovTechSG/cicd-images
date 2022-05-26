FROM alpine:3.15
LABEL maintainer="gyl <gylswork-at-gmail-com" \
      description="Amazon Web Services CLI image for use in CI pipelines"
ENV APK_DEPENDENCIES="bash curl git jq vim python3 make g++ docker py3-pip" \
    PIP_DEPENDENCIES="awscli" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"
COPY ./version-info /usr/bin/
RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && pip3 --no-cache-dir install ${PIP_DEPENDENCIES} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/kubectl \
    && chmod +x /usr/bin/version-info \
    && rm -rf ${PATHS_TO_REMOVE}
WORKDIR /
