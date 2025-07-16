
all: build up

build:
	@ docker compose \
	  -f docker-compose.yaml \
	  -f src/ros_docker/docker-compose.yaml \
	  build

up:
	@ docker compose \
	-f docker-compose.yaml \
	-f src/ros_docker/docker-compose.yaml \
	up

down:
	@ docker compose \
	-f docker-compose.yaml \
	-f src/ros_docker/docker-compose.yaml \
	down

%.shell: build
	@ xhost +local:docker
	@ docker compose \
		-f docker-compose.yaml \
		-f src/ros_docker/docker-compose.yaml \
		run \
		--rm \
		--remove-orphans \
		-it \
		"$(basename $@)" bash

.PHONY: all build up down
