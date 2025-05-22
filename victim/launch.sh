#!/bin/bash

# Stop and remove any previous container with the same name
echo "Stopping and removing existing poodle-victim container..."
sudo docker stop poodle-victim > /dev/null 2>&1
sudo docker rm poodle-victim > /dev/null 2>&1

echo "Building Docker image 'victim'..."
# Build the Docker image from the current directory's Dockerfile
sudo docker build -t victim .

echo "Launching Docker container 'poodle-victim' and mapping VNC port 5900..."
# Run the container
# -it: Interactive TTY (allows you to see logs if needed)
# -p 5900:5900: Map host port 5900 to container port 5900 (for VNC access)
# --name poodle-victim: Assign a specific name to the container
# victim: Use the image we just built
sudo docker run -it -d -p 5900:5900 --name poodle-victim victim

echo "Poodle victim container launched!"
echo "You should now be able to connect to VNC at vncviewer 127.0.0.1:5900"
echo "VNC Password: yourvncpassword123" # REMEMBER TO CHANGE THIS IN Dockerfile!
