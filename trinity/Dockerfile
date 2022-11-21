FROM ubuntu:22.04
LABEL maintainer="gyl" \
      description="Amazon Web Services CLI image for use in CI pipelines"

ENV DEPENDENCIES="\
      apt-transport-https gnupg-agent ca-certificates software-properties-common \
      bash curl git jq vim python3 make g++ python3-pip unzip" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/* \
      ~/.cache/pip/*"

COPY ./version-info /usr/bin/

RUN apt-get update \
    && apt-get install -y ${DEPENDENCIES} \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
    && apt-get install -y docker-ce docker-ce-cli containerd.io \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/kubectl \
    && chmod +x /usr/bin/version-info \
    && rm -rf ${PATHS_TO_REMOVE} \
    && useradd -m -u 1000 aws-cli

USER 1000

WORKDIR /
HEALTHCHECK NONE