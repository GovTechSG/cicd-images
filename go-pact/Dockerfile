ARG GOLANG_MAJOR_VERSION="refer to build.yaml"
ARG GOLANG_RELEASE="refer to build.yaml"
FROM public.ecr.aws/govtechsg/cicd-images:go-${GOLANG_MAJOR_VERSION}-${GOLANG_RELEASE}

WORKDIR /opt

ARG PACT_RUBY_STANDALONE_VERSION="1.91.0"
RUN curl -LO https://github.com/pact-foundation/pact-ruby-standalone/releases/download/v$PACT_RUBY_STANDALONE_VERSION/pact-$PACT_RUBY_STANDALONE_VERSION-linux-x86_64.tar.gz
RUN tar xzf pact-$PACT_RUBY_STANDALONE_VERSION-linux-x86_64.tar.gz

ENV PATH="/opt/pact/bin:${PATH}"
COPY ./version-info /usr/bin/
RUN chmod +x /usr/bin/version-info
WORKDIR /go/src

