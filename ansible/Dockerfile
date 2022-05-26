ARG alpine_ver=3.15
FROM alpine:${alpine_ver}
LABEL maintainer="salihan" \
      description="Image containing Ansible and Ansible-lint for use in CI/CD pipelines"

ARG user=cicd
ARG group=cicd

COPY ./version-info /usr/bin

ENV USERID="1101" \
  GROUPID="1101" \
  USER=${user} \
  GROUP=${group}

# hadolint ignore=DL3018,DL3013
RUN addgroup -S ${GROUP} -g ${GROUPID} \
  && adduser -D -S ${USER} -u ${USERID} -G ${GROUP} \
  && apk update \
  && apk add --no-cache python3 \
    python3-dev \
    musl-dev \
    libffi-dev \
    openssl-dev \
    make \
    openssh-client \
    sudo \
    curl \
    gcc \
    zip \
    bash \
    git \
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir ansible \
  && pip3 install --no-cache-dir ansible-lint \
  && pip3 install --no-cache-dir boto3 \
  && pip3 install --no-cache-dir boto \
  && ln -s /usr/bin/python3 /usr/bin/python \
  && rm -rf /usr/share/man/* \
    /usr/includes/* \
    /var/cache/apk/* \
  && deluser --remove-home daemon \
  && deluser --remove-home adm \
  && deluser --remove-home lp \
  && deluser --remove-home sync \
  && deluser --remove-home shutdown \
  && deluser --remove-home halt \
  && deluser --remove-home postmaster \
  && deluser --remove-home cyrus \
  && deluser --remove-home mail \
  && deluser --remove-home news \
  && deluser --remove-home uucp \
  && deluser --remove-home operator \
  && deluser --remove-home man \
  && deluser --remove-home cron \
  && deluser --remove-home ftp \
  && deluser --remove-home sshd \
  && deluser --remove-home at \
  && deluser --remove-home squid \
  && deluser --remove-home xfs \
  && deluser --remove-home games \
  && deluser --remove-home vpopmail \
  && deluser --remove-home ntp \
  && deluser --remove-home smmsp \
  && deluser --remove-home guest

USER ${USER}