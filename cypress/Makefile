TEST_PATH=$$(pwd)/test

build:
	@docker build -t cypress:local .

up: build
	@docker run -dt --rm --name cypress-local -v ${TEST_PATH}:/app/test --entrypoint tail cypress:local -f /dev/null

down:
	@docker stop cypress-local

conn:
	@docker exec -it cypress-local /bin/bash
