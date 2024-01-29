# Pin a version as atlantis:latest doesn't link to actual latest
FROM runatlantis/atlantis:v0.18.4

LABEL maintainer="Ryan <ryangohjq.dev-at-gmail-com>" \
      description="Atlantis docker image with customizations"
ENV APK_DEPENDENCIES="curl" \
    PIP_DEPENDENCIES="" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"

RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && cd /tmp \
    && curl -LO https://github.com/gruntwork-io/terragrunt/releases/download/$(curl --silent "https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /bin/terragrunt \
    && chmod +x /bin/terragrunt

RUN TERRAGRUNT_ATLANTIS_CONFIG_VERSION=$(curl --silent "https://api.github.com/repos/transcend-io/terragrunt-atlantis-config/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed -E 's/v//') \
    && cd /tmp \
    && curl -LO https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}/terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_amd64.tar.gz \
    && tar -zxvf terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_amd64.tar.gz \
    && mv /tmp/terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_amd64/terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_amd64 /bin/terragrunt-atlantis-config \
    && chmod +x /bin/terragrunt-atlantis-config

COPY ./version-info /usr/bin
RUN chmod +x /usr/bin/version-info

WORKDIR /