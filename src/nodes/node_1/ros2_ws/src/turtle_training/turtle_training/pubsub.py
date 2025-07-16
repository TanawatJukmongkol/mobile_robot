#!/usr/bin/env python3
import rclpy
from rclpy.node import Node

from geometry_msgs.msg import Twist
from turtlesim.msg import Pose

class TurtlePubSub(Node):
    def __init__(self):
        super().__init__('turtle_pubsub')
        
        # Variable
        self.cmd_vel_ = Twist()
        self.turtle_pose_ = Pose()
        self.state = False
        
        # ROS2 Publisher and Subscriber
        self.cmd_vel_pub_ = self.create_publisher(Twist, '/turtle1/cmd_vel', 10)
        self.create_subscription(Pose, '/turtle1/pose', self.commandPoseCallback, 10)
        
        # Initialise ROS Timers
        timer_period = 1 # Second
        self.timer = self.create_timer(timer_period, self.timer_callback)

    def commandPoseCallback(self, msg):
        self.turtle_pose_= msg
        self.get_logger().info(f"Turtle position: x:{self.turtle_pose_.x} y:{self.turtle_pose_.y}")
    
    def timer_callback(self):
        self.state = not self.state
        if self.state:
            self.cmd_vel_.linear.x = 1.0
            self.cmd_vel_.angular.z = 0.0
        else:
            self.cmd_vel_.linear.x = 0.0
            self.cmd_vel_.angular.z = 90 * 3.14159 / 180
        self.cmd_vel_pub_.publish(self.cmd_vel_)

def main(args=None):
    rclpy.init(args=args)

    turtle_pubsub_ = TurtlePubSub()
    rclpy.spin(turtle_pubsub_)
    turtle_pubsub_.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
