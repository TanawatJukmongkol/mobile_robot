#!/usr/bin/env python3
import rclpy
from rclpy.node import Node

from turtlesim.srv import TeleportAbsolute
from turtlesim.srv import TeleportRelative

class TurtleService(Node):
    def __init__(self):
        super().__init__('turtle_service')
        
        # ROS2 Service Server
        self.create_service(TeleportRelative,'/service_testing/teleport', self.commandTeleportCallback)
        
        # ROS2 Service Client
        self.turtle_teleop_cli_ = self.create_client(TeleportAbsolute, '/tanawat_jukmongkol/teleport_absolute')
        while not self.turtle_teleop_cli_.wait_for_service(timeout_sec=1.0):
            self.get_logger().info('service not available, waiting again...')
        self.teleportPosition(3.0, 7.0, 0.0)
        self.teleportPosition(7.0, 7.0, 0.0)
        self.teleportPosition(7.0, 3.0, 0.0)
        self.teleportPosition(3.0, 3.0, 0.0)

    # ROS2 Service Server Function
    def commandTeleportCallback(self, request, response):
        self.get_logger().info(f"Incoming request linear: {request.linear} angular: {request.angular}")
        return response
    
    # ROS2 Service Client Function
    def teleportPosition(self, x, y, theta):
        req = TeleportAbsolute.Request()
        req.x = x
        req.y = y
        req.theta = theta
        future = self.turtle_teleop_cli_.call_async(req)
        rclpy.spin_until_future_complete(self, future)
        if future.result() is not None:
            self.get_logger().info("Teleport service call succeeded.")
        else:
            self.get_logger().error("Teleport service call failed.")

def main(args=None):
    rclpy.init(args=args)
    turtle_service_ = TurtleService()
    rclpy.spin(turtle_service_)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
