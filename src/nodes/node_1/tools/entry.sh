#!/usr/bin/env bash

echo "Hello, world!"
source \$HOME/ros2_ws/install/local_setup.bash/bin/usr/env bash \$HOME/ros2_ws/install/local_setup.bash

exec runuser -u ubuntu "$@"