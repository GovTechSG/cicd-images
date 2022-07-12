#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
echo $VERSIONS
VERSION_CHROME=$(printf "${VERSIONS}" | grep chrome | cut -f 2 -d ':');
VERSION_FIREFOX=$(printf "${VERSIONS}" | grep firefox | cut -f 2 -d ':');
VERSION_CYPRESS=$(printf "${VERSIONS}" | grep cypress | cut -f 2 -d ':');
VERSION_NODE=$(printf "${VERSIONS}" | grep node | cut -f 2 -d ':');
EXISTENCE_TAG="${VERSION_CYPRESS}_chrome-${VERSION_CHROME}_firefox-${VERSION_FIREFOX}_node-${VERSION_NODE}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";

VERSION_NODE_MAJOR=$(echo -n "${VERSION_NODE}" | cut -d '.' -f1)
TAG_NODE_LATEST="${REPOSITORY_URL}-node${VERSION_NODE_MAJOR}-latest";

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
  docker tag ${TAG} ${TAG_NODE_LATEST};
  docker push ${TAG_NODE_LATEST};
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
fi;
