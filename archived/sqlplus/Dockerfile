FROM oraclelinux:7-slim

ARG ORACLE_VERSION=12.2

ENV ORACLE_VERSION=${ORACLE_VERSION}

# download oracle instantclient from s3 bucket
RUN pushd /tmp/ && \
    curl -O https://bgp-cicd-public.s3-ap-southeast-1.amazonaws.com/oracle_instantclient_12.2.0.1.0/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    curl -O https://bgp-cicd-public.s3-ap-southeast-1.amazonaws.com/oracle_instantclient_12.2.0.1.0/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm && \
    curl -O https://bgp-cicd-public.s3-ap-southeast-1.amazonaws.com/oracle_instantclient_12.2.0.1.0/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm && \
    popd
    
RUN  yum -y install /tmp/oracle-instantclient*.rpm && \
     rm -rf /var/cache/yum && \
     rm -f /tmp/oracle-instantclient*.rpm && \
     echo /usr/lib/oracle/${ORACLE_VERSION}/client64/lib > /etc/ld.so.conf.d/oracle-instantclient${ORACLE_VERSION}.conf && \
     yum clean all

ENV PATH=$PATH:/usr/lib/oracle/${ORACLE_VERSION}/client64/bin
COPY ./version-info /usr/bin
CMD ["sqlplus", "-v"]
