
all: build shell

build:
	@ docker compose build

shell:
	@ xhost +local:docker
	@ docker compose run \
		--rm \
		--remove-orphans \
		-it ros_docker bash
	@ xhost -local:docker

.PHONY: all build shell

