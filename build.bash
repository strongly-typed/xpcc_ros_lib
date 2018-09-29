#!/usr/bin/env bash

# Exit on first error
set -e

source /opt/ros/$ROS_DISTRO/setup.bash
source /catkin_ws/devel/setup.bash

# Remove generated files as make_libraries does not overwrite files
rm -rf ros_lib

# Generate message fiels
rosrun rosserial_mbed make_libraries.py .

# Remove unused files before committing
rm -rf ros_lib/BufferedSerial*
rm ros_lib/MbedHardware.h
rm ros_lib/ros.h
rm -rf ros_lib/rosserial_arduino
rm -rf ros_lib/rosserial_mbed

git status
