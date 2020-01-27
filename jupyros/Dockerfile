FROM osrf/ros:kinetic-desktop

# Install pip
RUN apt update && apt install -y python-pip

# Upgrade pip https://github.com/jupyter/jupyter/issues/71
RUN pip install --upgrade pip
# Fix error https://github.com/pypa/pip/issues/5447#issuecomment-407693701
# RUN hash -d pip

# Install Jupyter with some 
RUN pip install jupyter bqplot pyyaml ipywidgets numpy
# Note: numpy must be at least 1.12. If it does not install the
# correct version automatically, use this: pip install "numpy>=1.12"
RUN pip install "numpy>=1.12"
# RUN jupyter nbextension enable --py --sys-prefix ipywidgets
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Install jupyros
RUN pip install jupyros
RUN jupyter nbextension enable --py --sys-prefix jupyros

# Install npm and node (needed for jupyterlab)
RUN apt install -y curl && curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && bash nodesource_setup.sh
RUN apt install nodejs 
RUN rm /nodesource_setup.sh
# Install jupyterlab
RUN pip install jupyterlab

# Install the jupyer-ros extension for jupyterlab
RUN jupyter labextension install jupyter-ros

# Install tf2 web republisher and ros bridge server
RUN apt install -y ros-$ROS_DISTRO-rosbridge-server
RUN apt install -y ros-$ROS_DISTRO-tf2-web-republisher

# Install Caddy as a cors server
RUN curl https://getcaddy.com | bash -s personal http.cors

# Initialize the catkin workspace
WORKDIR /ros_ws/src
WORKDIR /ros_ws
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin_make"
# RUN /opt/ros/$ROS_DISTRO/bin/catkin_make
RUN /bin/bash -c "source devel/setup.bash"

# Clear apt cache.
RUN apt clean

# Expose the port 8888 for Jupyter
EXPOSE 8888

# Expose ports 9090 for rosbridge_server
EXPOSE 9090

# Expose ports 3000 for the cors server
EXPOSE 3000

# Set the workspace variable
ENV ROS_WORKSPACE=/ros_ws

# Copy the entrypoint script
COPY ./jupyros_entrypoint.sh /
ENTRYPOINT ["/jupyros_entrypoint.sh"]
