#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_GIT=$(printf "${VERSIONS}" | grep git | cut -f 2 -d ':');
VERSION_DOCKER=$(printf "${VERSIONS}" | grep 'docker:' | cut -f 2 -d ':');
VERSION_DOCKER_COMPOSE=$(printf "${VERSIONS}" | grep docker-compose | cut -f 2 -d ':');
VERSION_OPENSSH=$(printf "${VERSIONS}" | grep openssh | cut -f 2 -d ':');
VERSION_PYTHON3=$(printf "${VERSIONS}" | grep python | cut -f 2 -d ':');
VERSION_ZULU_JDK=$(printf "${VERSIONS}" | grep zulu-jdk | cut -f 2 -d ':');
VERSION_MYSQL_CLIENT=$(printf "${VERSIONS}" | grep mysql-client | cut -f 2 -d ':');

EXISTENCE_TAG="docker-${VERSION_DOCKER}_docker-compose-${VERSION_DOCKER_COMPOSE}_git-${VERSION_GIT}_python-${VERSION_PYTHON3}_zulujdk-${VERSION_ZULU_JDK}_openssh-${VERSION_OPENSSH}_mysql-client-${VERSION_MYSQL_CLIENT}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
DOCKER_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_DOCKER}";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
_="$(docker pull "${EXISTENCE_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${TAG_LATEST}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${DOCKER_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${DOCKER_VERSION_REPO_URL};
  docker push ${DOCKER_VERSION_REPO_URL};
fi;
