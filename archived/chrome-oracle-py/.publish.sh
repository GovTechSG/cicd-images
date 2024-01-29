#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_PYTHON=$(printf "${VERSIONS}" | grep python | cut -f 2 -d ':');
VERSION_PYTHON_MAJOR=$(printf "${VERSION_PYTHON}" | cut -f 1 -d '.');
VERSION_PYTHON_MINOR=$(printf "${VERSION_PYTHON}" | cut -f 2 -d '.');
VERSION_CHROME=$(printf "${VERSIONS}" | grep chrome:| cut -f 2 -d ':');
VERSION_CHROMEDRIVER=$(printf "${VERSIONS}" | grep chromedriver: | cut -f 2 -d ':');
VERSION_ORACLE=$(printf "${VERSIONS}" | grep oracle: | cut -f 2 -d ':');
EXISTENCE_TAG="python-${VERSION_PYTHON}_chrome-${VERSION_CHROME}_chromedriver-${VERSION_CHROMEDRIVER}-${VERSION_ORACLE}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${VERSION_ORACLE}-${VERSION_PYTHON_MAJOR}.${VERSION_PYTHON_MINOR}-${EXISTENCE_TAG}";
PYTHON_VERSION_REPO_URL="${REPOSITORY_URL}${VERSION_PYTHON_MAJOR}.${VERSION_PYTHON_MINOR}";

LATEST_REPO_URL="${REPOSITORY_URL}-${VERSION_ORACLE}-${VERSION_PYTHON_MAJOR}.${VERSION_PYTHON_MINOR}-latest";

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

  printf "Pushing [${PYTHON_VERSION_REPO_URL}]... \n";
  docker tag ${TAG} ${PYTHON_VERSION_REPO_URL};
  docker push ${PYTHON_VERSION_REPO_URL};
fi;
