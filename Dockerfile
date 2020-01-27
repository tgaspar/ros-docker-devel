FROM ros:kinetic

# Install pip
RUN apt update && apt install -y \
    python-pip \
    screen \
    vim \
    nano \
    git

RUN pip install --upgrade pip

RUN pip install catkin_tools

# Initialize the catkin workspace
WORKDIR /ros_ws/src
WORKDIR /ros_ws
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin build"
# RUN /opt/ros/$ROS_DISTRO/bin/catkin_make
RUN /bin/bash -c "source devel/setup.bash"

# Clear apt cache.
RUN apt clean

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws