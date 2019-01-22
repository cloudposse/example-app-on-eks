DOCKER_IMAGE_NAME ?= example-app
SHELL = /bin/bash

PATH:=$(PATH):$(GOPATH)/bin

-include $(shell curl -sSL -o .build-harness "https://git.io/build-harness"; echo .build-harness)

build: go/build
	@exit 0

run:
	docker run -it -p 8080:8080 --rm $(DOCKER_IMAGE_NAME)
