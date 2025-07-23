#!/usr/bin/env bash
set -e

# Prints debug information when DEBUG mode is set
pr_debug ()
{
  if [ -n "$DEBUG" ]; then
    echo $@
  fi
}

# setup ros2 environment
pr_debug "Loading ROS ($ROS_DISTRO) entry hook..."
source /opt/ros/$ROS_DISTRO/setup.bash

# User environment setup (can be copied in from /setup.sh)

source /global_setup.sh

if [ -f "/setup.sh" ]; then
  pr_debug "Run setup hook..."
  source /setup.sh
fi

# Runs either shell hook or entrypoint (depending on development mode)

pr_debug "Entry point command line: $@"

if [ -z "$@" ]; then
  # On deployment...]
  if [ -f "/entry.sh" ]; then
    pr_debug "Entrypoint starting..."
    exec runuser -u ubuntu /usr/bin/env bash /entry.sh
  else
    pr_debug "Entrypoint not found! if this behaviour is desired, create \"/entry.sh\"."
  fi

else

  # Shell hook...
  pr_debug "Enter the environment as ${ENTRY_USER:-ubuntu} user..."
  if [ -z "$DEBUG" ]; then
    exec runuser -u ubuntu "$@"
  else
    exec runuser -u "${ENTRY_USER:-ubuntu}" "$@"
  fi

fi