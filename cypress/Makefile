
build:
	@docker build -t cypress:local .

up: build
	@docker run -dt --rm --name cypress-local --entrypoint tail cypress:local -f /dev/null

conn:
	@docker exec -it cypress-local /bin/bash
