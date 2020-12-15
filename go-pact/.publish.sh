#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_GOLANG=$(printf "${VERSIONS}" | grep golang | cut -f 2 -d ':');
VERSION_PACT_MOCK_SERVICE=$(printf "${VERSIONS}" | grep pact-mock-service | cut -f 2 -d ':');
EXISTENCE_TAG="golang-${VERSION_GOLANG}_pact-mock-service-${VERSION_PACT_MOCK_SERVICE}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
GO_PACT_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_GOLANG}";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
_="$(docker pull "${EXISTENCE_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${TAG}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${GO_PACT_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${GO_PACT_VERSION_REPO_URL};
  docker push ${GO_PACT_VERSION_REPO_URL};
fi;
