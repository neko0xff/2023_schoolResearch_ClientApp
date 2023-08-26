DOCKER_COMPOSE = docker-compose
IMAGE_NAME = neko0xff/viewapp_v1_1
VERSION = 1.1.0

.PHONY: build up down logs

build: build-docker
up: docker-compose-up
down: docker-compose-down
logs: docker-compose-logs

build-docker:
    $(DOCKER_COMPOSE) build

docker-compose-up:
   $(DOCKER_COMPOSE) up -d

docker-compose-down:
    $(DOCKER_COMPOSE) down

docker-compose-logs:
    $(DOCKER_COMPOSE) logs --tail=100 -f
