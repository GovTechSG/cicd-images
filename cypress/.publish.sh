#!/bin/bash
REPOSITORY_URL=$1;

# e.g public.ecr.aws/<govtech-ecr-id>/cicd-images:cypress-next
NEXT_TAG="${REPOSITORY_URL}-next";

# e.g node-18.15.0-chrome-106.0.5249.61-1-ff-99.0.1-edge-114.0.1823.51-1
EXISTENCE_TAG=$2;

# e.g public.ecr.aws/<govtech-ecr-id>/cicd-images:cypress-node-18.15.0-chrome-106.0.5249.61-1-ff-99.0.1-edge-114.0.1823.51-1
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";

# e.g public.ecr.aws/<govtech-ecr-id>/cicd-images:cypress-nodev18-latest
VERSION_NODE_MAJOR=$(node -v | cut -d '.' -f1)
TAG_NODE_LATEST="${REPOSITORY_URL}-node${VERSION_NODE_MAJOR}-latest";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
_="$(docker pull "${EXISTENCE_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${TAG_LATEST}]... ";
  docker tag ${TAG} ${TAG_NODE_LATEST};
  docker push ${TAG_NODE_LATEST};
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
fi;