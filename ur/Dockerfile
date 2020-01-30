FROM ros:devel

# Install pip
RUN apt update && apt install -y \
	ros-kinetic-rosbridge-suite 

WORKDIR /ros_ws/src
RUN git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git
RUN git clone -b calibration_devel https://github.com/fmauch/universal_robot.git

WORKDIR /ros_ws/
RUN rosdep update
RUN rosdep install --from-path src --ignore-src -y
RUN catkin build

RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin build"
RUN /bin/bash -c "source devel/setup.bash"

# Clear apt cache.
RUN apt clean

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws