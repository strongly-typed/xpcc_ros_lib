# ROS Library for XPCC

Repository of generated headers from rosserial.

These files were generated with `./rosserial_mbed/src/rosserial_mbed/make_libraries.py` from `jade-devel` branch in rosserial.


## Fully walk-through

Start a docker container with this directory mounted to `/ros_lib`

    docker run --interactive --tty --rm --mount type=bind,source=$PWD,target=/ros_lib ros:kinetic-perception-xenial /bin/bash

Install whatever ROS package you want. The packages in the container are sometime a bit outdated, so it is updated.

    apt update
    apt install -y -qq ros-kinetic-actionlib-tutorials ros-kinetic-control-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-gazebo-msgs ros-kinetic-geometry-msgs ros-kinetic-hector-nav-msgs ros-kinetic-nav-msgs ros-kinetic-pcl-msgs ros-kinetic-hector-slam ros-kinetic-rospy-tutorials ros-kinetic-turtle-actionlib ros-kinetic-turtlesim ros-kinetic-smach-msgs ros-kinetic-map-msgs ros-kinetic-roscpp-tutorials
    apt dist-upgrade -y -qq

Create a ROS workspace

    mkdir -p /catkin_ws/src
    cd /catkin_ws/src
    catkin_init_workspace .

Add the `rosserial` as source package and build it

    git clone https://github.com/ros-drivers/rosserial.git
    cd /catkin_ws
    catkin_make

Source the ROS workspace (including the system path as you may have installed new packages)

    source /opt/ros/kinetic/setup.bash
    source devel/setup.bash

Delete the generated files as `make_libraries.py` will not overwrite them

    rm -rf /ros_lib/ros_lib/

Create all files again

    rosrun rosserial_mbed make_libraries.py /ros_lib

Do not check in:

    rm -rf /ros_lib/ros_lib/BufferedSerial*
    rm /ros_lib/ros_lib/MbedHardware.h
    rm /ros_lib/ros_lib/ros.h
    rm -rf /ros_lib/ros_lib/rosserial_arduino
    rm -rf /ros_lib/ros_lib/rosserial_mbed
