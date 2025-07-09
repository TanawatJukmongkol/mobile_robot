
SHELL_CMD = \
	docker compose run \
		--rm \
		--remove-orphans \
		-it

all: build up

build:
	@ docker compose build

up:
	@ docker compose up

down:
	@ docker compose down

shell-ros_docker:
	@ xhost +local:docker
	@ ${SHELL_CMD} ros_docker bash

shell-node-robot1:
	@ xhost +local:docker
	@ ${SHELL_CMD} node_robot1 bash

.PHONY: all build up down shell-ros_docker shell-node-robot1
