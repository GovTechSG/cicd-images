#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_DEPHASH=$(printf "${VERSIONS}" | grep -e 'dephash:' | cut -f 2 -d ':');
EXISTENCE_TAG="dephash-${VERSION_DEPHASH}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
DEPHASH_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_DEPHASH}";

TAG_LATEST="${REPOSITORY_URL}-latest";

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
  printf "Pushing [${DEPHASH_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${DEPHASH_VERSION_REPO_URL};
  docker push ${DEPHASH_VERSION_REPO_URL};
fi;