ARG alpine_ver=3.11.3
FROM alpine:${alpine_ver}
LABEL maintainer="salihan" \
      description="Image containing Ansible and Ansible-lint for use in CI/CD pipelines"

ARG python=3.8.1-r0
ARG openssh_client=8.1_p1-r0
ARG sudo=1.8.29-r0
ARG curl=7.67.0-r0
ARG gcc=9.2.0-r3
ARG zip=3.0-r7
ARG bash=5.0.11-r1
ARG ansible=2.9.3-r0
ARG pip_ver=19.3.1
ARG ansible_lint=4.2.0
ARG boto3_ver=1.11.5
ARG boto2_ver=2.49.0
ARG user=cicd
ARG group=cicd

COPY ./version-info /usr/bin

ENV USERID="1101" \
  GROUPID="1101" \
  PYTHON=${python} \
  OPENSSH_CLIENT=${openssh_client} \
  SUDO=${sudo} \
  CURL=${curl} \
  GCC=${gcc} \
  ZIP=${zip} \
  BASH=${bash} \
  ANSIBLE=${ansible} \
  PIP=${pip_ver} \
  ANSIBLE_LINT=${ansible_lint} \
  BOTO3=${boto3_ver} \
  BOTO2=${boto2_ver} \
  USER=${user} \
  GROUP=${group}

RUN addgroup -S ${GROUP} -g ${GROUPID} \
  && adduser -D -S ${USER} -u ${USERID} -G ${GROUP} \
  && apk update \
  && apk add --no-cache python3=${PYTHON} \
    openssh-client=${OPENSSH_CLIENT} \
    sudo=${SUDO} \
    curl=${CURL} \
    gcc=${GCC} \
    zip=${ZIP} \
    bash=${BASH} \
    ansible=${ANSIBLE} \
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --no-cache-dir --upgrade pip==${PIP} \
  && pip3 install --no-cache-dir ansible-lint==${ANSIBLE_LINT} \
  && pip3 install --no-cache-dir boto3==${BOTO3} \
  && pip3 install --no-cache-dir boto==${BOTO2} \
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