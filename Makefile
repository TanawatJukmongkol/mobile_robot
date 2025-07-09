
SHELL_CMD = \
	docker compose run \
		--rm \
		--remove-orphans \
		-it

all: build

build:
	@ docker compose build

shell-ros_docker:
	@ xhost +local:docker
	@ ${SHELL_CMD} ros_docker bash

shell-node-robot1:
	@ xhost +local:docker
	@ ${SHELL_CMD} node_robot1 bash

.PHONY: all build shell
