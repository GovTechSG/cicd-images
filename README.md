# CI/CD Containers for Pipelines

![Build and Publish](https://github.com/govtechsg/cicd-images/workflows/build%20and%20publish/badge.svg)

This repository is a collection of Docker images we use internally for continuous integration/delivery pipelines.

Daily builds are run against these images and automatically sent to our DockerHub and the public ECR repository at

https://hub.docker.com/r/govtechsg/cicd-images

https://gallery.ecr.aws/l5k6t5t7/cicd-images

## Catalog (Alphabetical Order)

- Alpine Linux (`alpine`)
- Ansible (`ansible`)
- Atlantis (`atlantis`)
- Amazon Web Services CLI (`awscli`): no longer maintained; use the official image from AWS, https://hub.docker.com/r/amazon/aws-cli
- Cypress (`cypress`)
- Playwright (`playwright`)
- Docker-in-Docker (`dind`)
- Google Kubernetes Engine CLI (`gkecli`)
- Karma Test Runner (`karma`)
- Kubernetes Client (`kubectl`)
- Trinity (`awscli` + `docker` + `kubectl`)
- Node.js (`node`)
- Pivotal Tracker Commit json (`pivotaltracker-commit`)
- Robot Selenium Generic Image (`chrome-oracle-py`)
- Sqlplus (`sqlplus`)
- Version Tagging Scripts (`vtscripts`)

### Release Notes

The images are found in the [DockerHub registry](https://hub.docker.com/r/govtechsg/cicd-images), and the names of the different types of images are added as a tag. For example given a type of image called `xyz`, it will be available under the repository URL `govtechsg/cicd-images:xyz-latest`. Specific versions can be found in the [DockerHub Tags page](https://hub.docker.com/r/govtechsg/cicd-images/tags/)

### Universal Tooling

All images will contain some tools essential for most operations that will happen in a continuous integration/delivery pipeline. These tools are:

- `bash`
- `curl`
- `jq`
- `vim`
- `git`

### Usage/Descriptions

#### `alpine`

Canonical Tag: `alpine-<ALPINE_VERSION>` \
Latest URL: `govtechsg/cicd-images:alpine-latest`

##### Notes

We use Alpine for our production deployments, only makes sense to run stuff in Alpine. This image contains common tools in pipelines and should serve most general needs. If you need more pacakges, feel free to submit a pull request with the required APK packages.

#### `ansible`

Canonical Tag: `ansible-<ANSIBLE_VERSION>` \
Latest URL: `govtechsg/cicd-images:ansible-latest`

##### Notes

This image also contains Ansible-lint and Boto3 so you can lint your Ansible playbooks and use Ansible playbooks to automate stuff on AWS respectively

#### `atlantis`

Canonical Tag: `atlantis-<ANSIBLE_VERSION>` \
Latest URL: `govtechsg/cicd-images:atlantis-latest`

#### `cypress`

Canonical Tag: `cypress-<REPO_VERSION>` \
Latest URL: `govtechsg/cicd-images:cypress-latest`

##### Notes

#### `playwright`



##### Notes

- Playwright is an automation tool used for the integration tests (similar to Cypress)
- We decided to use Playwright to simulate concurrent sessions which Cypress cannot simulate due to it's architectural limitation
- This concurrent session tests are required to test the Singpass single active session rule
- More info about Playwright: https://playwright.dev/docs/intro

#### `dephash`

Canonical Tag: `dephash-<REPO_VERSION>` \
Latest URL: `govtechsg/cicd-images:dephash-latest`

##### Notes

See https://github.com/govtechsg/version-tagging-scripts for more information on using this. Commands are symbolic linked to the system variable directory so you can use the following commands:

- `dephash ./path/to/file --npm`
- `dephash ./path/to/file --npm --prod`
- `dephash ./path/to/file --npm --dev`
- `dephash ./path/to/file --yarn`

#### `dind`

Canonical Tag: `dind-<DOCKER_VERSION>` \
Latest URL: `govtechsg/cicd-images:dind-latest`

##### Notes

You will need to configure this image so that the host file at path `/var/run/docker.sock` is mapped to the `/var/run/docker.sock` in the container.

- https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
- https://www.develves.net/blogs/asd/2016-05-27-alternative-to-docker-in-docker/
- https://getintodevops.com/blog/the-simple-way-to-run-docker-in-docker-for-ci

#### `gkecli`

Canonical Tag: `gkecli-<GOOGLE_SDK_VERSION>` \
Latest URL: `govtechsg/cicd-images:gkecli-latest`

##### Notes

An additional child image, or a script should be added to this to set Google credentials and retrieve the Kubernetes configurations.

- https://cloud.google.com/kubernetes-engine/docs/quickstart

#### `karma`

Canonical Tag: `karma-<CHROMIUM_VERSION>` \
Latest URL: `govtechsg/cicd-images:karma-latest`

##### Notes

Karma is not included in the `karma` image, this image only provides the base for it to run ChromeHeadless. Remember to include the `--no-sandbox` flag in the Karma configuration.

#### `kubectl`

Canonical Tag: `kubectl-<KUBECTL_VERSION>` \
Latest URL: `govtechsg/cicd-images:kubectl-latest`

##### Notes

For use when there's a deployment to a Kubernetes deployment.

#### `node`

Canonical Tag: `node-<NODE_VERSION>` \
Latest URL: `govtechsg/cicd-images:node<NODE_MAJOR_VERSION>-latest`

##### Notes

All LTS versions of Node, and the latest major version (LTS or otherwise) are builit.

- https://github.com/nodejs/Release

#### `pivotaltracker-commit`

Canonical Tag: `pivotaltracker-commit-ruby-<VERSION_RUBY>_code-><VERSION_CODE>` \
Latest URL: `govtechsg/cicd-images:pivotaltracker-commit-latest`

#### `chrome-oracle-py`

Canonical Tag: `chrome-oracle-py-<ORACLE_VERSION>-<PYTHON_VERSION>` \
Latest URL: `govtechsg/cicd-images:chrome-oracle-py-<ORACLE_VERSION>-<PYTHON_VERSION>-latest`

Python Versions:
* 2.7
* 3.6
* 3.7

Oracle Versions:
* 12.2.0.1.0

##### Notes
* Versions available are listed [here](https://hub.docker.com/_/python/). The downloaded python image version will be as follows: python:${PYTHON_VERSION}-slim-stretch
* For use as a base image for robot regression frameworks.
  1. pip freeze > requirements.txt in regression project folder
  2. Add this instruction to your regression Dockerfile
      ```
      COPY requirements.txt ./
      RUN pip install -r requirements.txt
      ```
      Or just just mount requirements.txt to container and include `pip install -r requirements.txt` in your entrypoint.

#### `sqlplus`
Canonical Tag: `sqlplus-<ORACLE_VERSION>` \
Latest URL: `govtechsg/cicd-images:sqlplus-<ORACLE_VERSION>-latest`

Oracle Versions:
* 12.2

#### `trinity`

Canonical Tag: `trinity-<AWS_CLI_VERSION>-<DOCKER_VERSION>-<KUBECT_VERSION>` \
Latest URL: `govtechsg/cicd-images:trinity-latest`

#### `vtscripts`

Canonical Tag: `vtscripts-<VTSCRIPTS>` \
Latest URL: `govtechsg/cicd-images:vtscripts-latest`

##### Notes

See https://github.com/govtechsg/version-tagging-scripts for more information on using this. Commands are symbolic linked to the system variable directory so you can use the following commands:

- `init -q`
- `get-branch -q`
- `get-latest -q`
- `get-next -q`
- `iterate -q`

## Other Uses

Images specified here can be uploaded to other repositories if you so wish. The commands are:

### For Building

The build script creates the build for the specified image:

```bash
DH_REPO=__URL_TO_REPO__
IMAGE_NAME=__DIRECTORY_NAME__
./.scripts/.build.sh "${DH_REPO}" "${IMAGE_NAME}"
```

An example to upload to a DockerHub at `yourusername/yourimage:dind-latest`:

```bash
DH_REPO="yourusername/yourimage"
IMAGE_NAME="dind"
./.scripts/.build.sh "${DH_REPO}" "${IMAGE_NAME}"
```

### For Publishing

The publish script in each directory sends your built image to DockerHub and relies on the `./.scripts/.build.sh` script being run prior to it. The general format of usage:

```bash
DH_REPO=__URL_TO_REPO__
IMAGE_NAME=__DIRECTORY_NAME__
./${IMAGE_NAME}/.publish.sh "${DH_REPO}:${IMAGE_NAME}"
```

A corresponding example to upload to a DockerHub repository at `yourusername/yourimage:dind-latest`:

```bash
DH_REPO="yourusername/yourimage"
IMAGE_NAME="dind"
./${IMAGE_NAME}/.publish.sh "${DH_REPO}:${IMAGE_NAME}"
```

Each directory and type of image has its own publish script because of the different ways they are versioned.
