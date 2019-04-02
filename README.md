# docker-paperless

Scan, index, and archive all of your paper documents

Inofficial container for the [paperless project](https://github.com/the-paperless-project/paperless)

This container is similar to the paperles project including a healthcheck and small optimizations.

# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-paperless.svg?branch)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-paperless.svg?branch)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-paperless.svg?branch)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-paperless/
[microbadger]: https://microbadger.com/images/bodsch/docker-paperless
[travis]: https://travis-ci.org/bodsch/docker-paperless


# Build
Your can use the included Makefile.

To build the Container: `make`

To remove the builded Docker Image: `make clean`

Starts the Container: `make run`

Starts the Container with Login Shell: `make shell`

Entering the Container: `make exec`

Stop (but **not kill**): `make stop`

Create a valide `docker-compose.yml`: `make compose-file`

After then, you can build and run the containers with docker-compose.

# Project Documentation
It's all available on [ReadTheDocs](https://paperless.readthedocs.io/).


# Docker Hub
You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-paperless)

## get
`docker pull bodsch/docker-paperless`

# supported Environment Vars
- `PAPERLESS_OCR_LANGUAGES`  (default: empty)
- `PAPERLESS_PASSPHRASE`  (default: empty)
- `PAPERLESS_CONSUMPTION_DIR` (default: empty)
- `PAPERLESS_CONSUME_MAIL_HOST` (default: empty)
- `USERMAP_UID` (default: `1000`)
- `USERMAP_GID` (default: `1000`)

# Ports
- 8000
