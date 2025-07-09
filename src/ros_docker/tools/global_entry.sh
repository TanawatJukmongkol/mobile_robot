#!/usr/bin/env bash
set -e

# setup ros2 environment
echo "Loading ROS ($ROS_DISTRO) entry hook..."
source "/opt/ros/$ROS_DISTRO/setup.bash" --

# User environment setup (can be copied in from /setup.sh)

runuser -u ubuntu /usr/bin/env bash /global_setup.sh

if [ -f "/setup.sh" ]; then
  echo "Run setup hook..."
  runuser -u ubuntu /usr/bin/env bash /setup.sh
fi

# Runs either shell hook or entrypoint (depending on development mode)
if [ -z "$@" ]; then

  if [ -f "/entry.sh" ]; then
    echo "Entrypoint starting..."
    exec runuser -u ubuntu /usr/bin/env bash /entry.sh
  else
    echo "Entrypoint not found! if this behaviour is desired, create \"/entry.sh\"."
  fi

else

  echo "Enter the environment as non-root..."
  exec runuser -u ubuntu "$@"

fi