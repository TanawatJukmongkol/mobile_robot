#!/usr/bin/env bash

set -e

echo "Loading ROS ($ROS_DISTRO) entry hook..."
source	"/opt/ros/$ROS_DISTRO/setup.bash" --

echo "Switching to non-root..."
exec runuser -u ubuntu "$@"

