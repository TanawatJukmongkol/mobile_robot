FROM osrf/ros:jazzy-desktop

# Configure base system
RUN			apt-get update
RUN			apt-get install -y locales
RUN			locale-gen en_US en_US.UTF-8
RUN			update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# ROS desktop packages
RUN			apt-get install -y \
			ros-dev-tools \
			ros-jazzy-desktop

# Install system utilities
RUN			apt-get install -y \
			iproute2

RUN			chown -R 1000:users /tmp
RUN			chmod 0700 /tmp

# Copies setup and entrypoint hooks
RUN			rm -f /ros_entrypoint.sh
COPY		tools/global_setup.sh /global_setup.sh
COPY		tools/global_entry.sh /global_entry.sh

WORKDIR		/home/ubuntu
ENTRYPOINT	[ "bash", "/global_entry.sh" ]
