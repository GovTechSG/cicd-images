# color
red=$'\e[1;31m'
green=$'\e[0;32m'
yellow=$'\e[0;33m'
end=$'\e[0m'

# variables
NAME:=
VERSION=local
TAG=${NAME}:${VERSION}

# functions
precheck:
	@if [ -z "${NAME}" ]; then printf -- "${red}NAME is required.${end}\ne.g. (make xxxx NAME=trinity)\n"; ls -d */; exit 1; fi

build: precheck
	docker build --tag ${TAG} ./${NAME}/

up: build
	docker run --rm -dt --name ${NAME} --entrypoint tail ${TAG} -f /dev/null

down: precheck
	docker stop ${NAME}

conn: precheck
	docker exec -it ${NAME} /bin/bash

test: build
	@docker run --rm --name ${NAME} --entrypoint version-info ${TAG}

#push: build
#	docker push ${TAG}
