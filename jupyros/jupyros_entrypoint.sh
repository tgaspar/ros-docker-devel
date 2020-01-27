#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
# source "source $ROS_WORKSPACE/devel/setup.bash"

# Create and populate the meshes dir (assuming we are in the right dir)
mkdir -p meshes
cd src && find . -regex  '.*\(stl\|.STL\)$' -exec cp --parents \{} ../meshes \; && cd ..

# Start Caddy
caddy -port 3000 -host 0.0.0.0 -root $MESHES_DIR &

# # Start tf2_web_republisher and rosbridge_server
# roslaunch rosbridge_server rosbridge_websocket.launch &
# rosrun tf2_web_republisher tf2_web_republisher  &

# Finally, lunch Jupyter
jupyter notebook --ip=0.0.0.0 --notebook-dir='src/' --no-browser --allow-root  --NotebookApp.token='' --NotebookApp.password=''