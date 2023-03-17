ARG GOLANG_MAJOR_VERSION="refer to build.yaml"
ARG GOLANG_RELEASE="refer to build.yaml"
FROM public.ecr.aws/docker/library/golang:${GOLANG_MAJOR_VERSION}-${GOLANG_RELEASE}

COPY ./version-info /usr/bin/
RUN chmod +x /usr/bin/version-info
WORKDIR /go/src

