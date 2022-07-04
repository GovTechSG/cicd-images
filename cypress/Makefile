NAME=cypress
NAME_LOCAL=cypress-local
NAME_TEST=cypress-test
TAG_LOCAL=cypress:local
TEST_PATH=$$(pwd)/test

build:
	@docker build -t ${NAME}:local .

up: build
	@docker run -dt --rm --name ${NAME_LOCAL} -v ${TEST_PATH}:/app/test --entrypoint tail ${TAG_LOCAL} -f /dev/null

down:
	@docker stop ${NAME_LOCAL}

test: build
	@docker run -t --name ${NAME_TEST} -v ${TEST_PATH}:/app/test --entrypoint /bin/bash ${TAG_LOCAL} -c "cd /app/test && ./init.sh"

conn:
	@docker exec -it ${NAME_LOCAL} /bin/bash
