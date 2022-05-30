FROM docker:20.10.16-alpine3.15

LABEL maintainer="Ryan <Ryan_goh@tech-gov-sg>" \
      description="Docker-in-Docker container for use in CI pipelines"

ENV APK_DEPENDENCIES="bash curl git jq vim openssh build-base python3 python3-dev py3-pip gnupg mysql-client nss libffi-dev openssl-dev rust cargo zulu17-jdk" \
    PIP_DEPENDENCIES="docker-compose" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"

WORKDIR /

COPY ./version-info /usr/bin/

RUN wget -P /etc/apk/keys/ https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub \
    && echo "https://repos.azul.com/zulu/alpine" | tee -a /etc/apk/repositories \
    && apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && pip --no-cache-dir install ${PIP_DEPENDENCIES} \
    && alias md5='md5sum' \
    && rm -rf ${PATHS_TO_REMOVE} \
    && chmod +x /usr/bin/version-info

VOLUME ["/var/run/docker.sock", "/cache"]
