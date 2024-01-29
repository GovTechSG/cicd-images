#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_ORACLE=$(printf "${VERSIONS}" | grep oracle: | cut -f 2 -d ':');
EXISTENCE_TAG="oracle-${VERSION_ORACLE}"
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";

LATEST_REPO_URL="${REPOSITORY_URL}-${VERSION_ORACLE}-latest";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
_="$(docker pull "${EXISTENCE_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  
  printf "Pushing [${EXISTENCE_REPO_URL}]... \n";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  
  printf "Pushing [${LATEST_REPO_URL}]... \n";
  docker tag ${TAG} ${LATEST_REPO_URL};
  docker push ${LATEST_REPO_URL};
fi;
