FROM amazon/aws-cli:2.8.13
LABEL maintainer="gyl" \
      description="Amazon Web Services CLI image for use in CI pipelines"

ENV APK_DEPENDENCIES="bash curl git jq vim python3 make g++ docker py3-pip" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/* \
      ~/.cache/pip/*"

COPY ./version-info /usr/bin/

RUN yum install -y "${APK_DEPENDENCIES}" \
    && rm -rf "${PATHS_TO_REMOVE}" \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/kubectl \
    && chmod +x /usr/bin/version-info \
    && rm -rf "${PATHS_TO_REMOVE}" \
    && useradd -m -u 1000 aws-cli

USER 1000

WORKDIR /
HEALTHCHECK NONE
