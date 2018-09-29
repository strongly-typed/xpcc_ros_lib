FROM ros:kinetic-perception-xenial

COPY package.list .
COPY ros_lib /ros_lib
COPY build.bash /

SHELL ["/bin/bash", "-c"]

# Install packages and update
RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
    apt-get update -qq && \
    apt-get install -qq -y $(awk -v ROS_DISTRO=$ROS_DISTRO '{print "ros-" ROS_DISTRO "-" $1 '} /package.list) && \
    apt-get dist-upgrade -qq -y && \
    rm -rf /var/lib/apt/lists/*

# make_libraries.py is not distributed in the rosserial package.
# It is only available in the source
WORKDIR /catkin_ws
RUN git clone https://github.com/ros-drivers/rosserial.git src/rosserial

RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
    catkin_init_workspace src && \
    catkin_make && \
    source devel/setup.bash
