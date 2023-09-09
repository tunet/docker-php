SHELL := /bin/sh
include .env


build-and-push:
	docker buildx build \
		--push \
		--platform linux/amd64,linux/arm64 \
		--tag tunet/php:${PHP_VERSION} \
		-f ./Dockerfile \
		--build-arg PHP_VERSION=${PHP_VERSION} \
		.
