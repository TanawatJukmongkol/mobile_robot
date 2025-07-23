# mobile_robot

A basic ROS2 docker framework for composing multiple nodes.

# Structure

mobile_robot
|- .git
|- .gitignore
|- docker-compose.yaml
|- Makefile
|- README.md
|- src
    |- nodes (your nodes)
    |   |- node_name
    |       |- Dockerfile
    |       |- ros2_ws (your ROS2 workspace)
    |       |- tools (scripts and hooks)
    |           |- entry.sh (runs the robot service / node. Ex: `ros2 run my_node`)
    |           |- setup.sh (used for setting up the environment, etc.)
    |- ros_docker (the parent template docker node)

# Usage

To start all ROS nodes in the foreground, use:
> make up

To start all ROS nodes in the background, use:
> make daemon

To stop all ROS nodes, use:
> make stop

To attach a debug shell to a node:
> make node_name.shell

To attach a debug shell to a node as root:
Note: (on docker rootless, root is treated as your host's user):
> make node_name.root

To run / debug a node's entry.sh use:
Note: (on docker rootless, root is treated as your host's user):
> make node_name.entry

