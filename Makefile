export BUILD_DATE                              := $(shell date +%Y-%m-%d)
export BUILD_FLUENTD_VERSION                   := v1.9.0-1.0
export BUILD_FLUENTD_PLUGIN_PROMETHEUS_VERSION := 1.7.0
export BUILD_VERSION                           := ${BUILD_FLUENTD_VERSION}_${BUILD_FLUENTD_PLUGIN_PROMETHEUS_VERSION}
export BUILD_DOCKER_TAG                        ?= ${BUILD_VERSION}
export DOCKER_IMAGE_NAME                       ?= fluentd-prometheus
export DOCKER_NAME_SPACE                       ?= alexandertgtalbot
export GIT_SHA1                                := $(shell git rev-parse --short HEAD)

.PHONY: build shell run exec start stop clean compose-file

default: build

build:
	@hooks/build

linter:
	@tests/linter.sh
