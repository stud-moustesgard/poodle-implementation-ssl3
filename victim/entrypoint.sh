#!/bin/bash

# Start a virtual X display (display :0)
# -ac: Disable access control (important for x11vnc)
Xvfb :0 -screen 0 1024x768x24 &
export DISPLAY=:0

# Give Xvfb a moment to start up
sleep 2

# Start a lightweight window manager (Fluxbox)
fluxbox &

# Wait for Fluxbox to initialize (optional, but can help with stability)
sleep 2

# Launch Firefox (wait for it to appear before VNC connects)
# & ensures it runs in the background
firefox &

# Start x11vnc server
# -forever: Don't exit after one client disconnects
# -loop: Keep trying to connect
# -display :0: Connect to our virtual display
# -autoport 5900: Listen on port 5900
# -nopw: If you don't want a password (NOT RECOMMENDED for anything but isolated lab)
# -rfbauth ~/.vnc/passwd: Use the password file we created
# -viewonly: If you want to disable remote control (not useful for this lab)
echo "Starting x11vnc server on display :0"
exec x11vnc -forever -loop -display :0 -rfbport 5900 -rfbauth ~/.vnc/passwd -o /var/log/x11vnc.log

