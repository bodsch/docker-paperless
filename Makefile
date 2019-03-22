export GIT_SHA1          := $(shell git rev-parse --short HEAD)
export DOCKER_IMAGE_NAME := paperless
export DOCKER_NAME_SPACE := ${USER}
export DOCKER_VERSION    ?= latest
export BUILD_DATE        := $(shell date +%Y-%m-%d)
export BUILD_VERSION     := $(shell date +%y%m)
export BUILD_TYPE        ?= stable
export PAPERLESS_VERSION ?= 2.7.0


.PHONY: build shell run exec start stop clean compose-file

default: build

build:
	@hooks/build

shell:
	@hooks/shell

clean:
	@hooks/clean

compose-file:
	@hooks/compose-file

linter:
	@test/linter.sh

integration_test:
	@test/integration_test.sh

test: linter integration_test
