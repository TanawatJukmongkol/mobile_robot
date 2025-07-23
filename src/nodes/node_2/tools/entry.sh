#!/usr/bin/env bash

echo "Starting turtle_service..."
ros2 service call /spawn turtlesim/srv/Spawn "{x: 3.0, y: 3.0, theta: 0.0, name: 'tanawat_jukmongkol'}"
ros2 run turtle_training turtle_service
