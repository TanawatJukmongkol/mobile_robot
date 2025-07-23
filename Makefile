
all: up

build:
	@ docker compose \
	  -f docker-compose.yaml \
	  -f src/ros_docker/docker-compose.yaml \
	  build

up: build
	@ docker compose \
	-f docker-compose.yaml \
	-f src/ros_docker/docker-compose.yaml \
	up

daemon: build
	@ docker compose \
	-f docker-compose.yaml \
	-f src/ros_docker/docker-compose.yaml \
	up -d

down:
	@ docker compose \
	-f docker-compose.yaml \
	-f src/ros_docker/docker-compose.yaml \
	down

# Debug shell into a container normally.
%.shell: build
	@ xhost +local:docker
	@ docker compose \
		-f docker-compose.yaml \
		-f src/ros_docker/docker-compose.yaml \
		run \
		--rm \
		--remove-orphans \
		-e DEBUG=1 \
		-it \
		"$(basename $@)" bash

# Debug shell into a container as root.
%.root: build
	@ xhost +local:docker
	@ docker compose \
		-f docker-compose.yaml \
		-f src/ros_docker/docker-compose.yaml \
		run \
		--rm \
		--remove-orphans \
		-e DEBUG=1 \
		-e ENTRY_USER=root \
		-it \
		"$(basename $@)" bash

# Debug a node entrypoint.
%.entry: build
	@ xhost +local:docker
	@ docker compose \
		-f docker-compose.yaml \
		-f src/ros_docker/docker-compose.yaml \
		run \
		--rm \
		--remove-orphans \
		-e DEBUG=1 \
		-it \
		"$(basename $@)" ""

.PHONY: all build up daemon down
