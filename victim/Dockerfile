# Use an older Ubuntu base image that was contemporary with Firefox 34
FROM ubuntu:14.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

# Install necessary packages:
# - xvfb: Provides Xvfb, the virtual display server
# - x11vnc: VNC server to share the X session
# - tightvncserver: Provides 'vncpasswd' and other VNC utilities
# - fluxbox: A very lightweight window manager, good for VNC
# - xterm: A basic terminal, useful for debugging
# - wget: To download Firefox
# - procps: For 'ps' command, often useful
# - libdbus-glib-1-2: Dependency for older Firefox versions on some systems
# - libxtst6: Required for some X-related functionalities that Firefox might use
# - libgtk2.0-0: Older GTK+ libraries for older Firefox
# - libstdc++6: C++ standard library, sometimes needed for older binaries
# - libasound2: ALSA sound library, required by older Firefox
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    tightvncserver \
    fluxbox \
    xterm \
    wget \
    procps \
    libdbus-glib-1-2 \
    libxtst6 \
    libgtk2.0-0 \
    libstdc++6 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# --- Install Firefox 34 ---
# Download Firefox 34.0 (English US)
# You might need to verify this exact URL if it ever changes.
# This is from Mozilla's official archive.
ENV FIREFOX_VERSION=34.0
ENV FIREFOX_URL=https://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2

# Create a directory for Firefox, download, extract, and clean up.
# Make it accessible via a symlink in /usr/local/bin
RUN mkdir -p /opt/firefox \
    && wget -q "${FIREFOX_URL}" -O /tmp/firefox.tar.bz2 \
    && tar -xf /tmp/firefox.tar.bz2 -C /opt \
    && rm /tmp/firefox.tar.bz2 \
    && ln -s /opt/firefox/firefox /usr/local/bin/firefox

# --- Configure Firefox Preferences ---
# Copy the custom preference file into Firefox's default preferences directory.
# This ensures the proxy and SSL/TLS settings are applied automatically.
COPY firefox-prefs.js /opt/firefox/defaults/pref/

# --- VNC Configuration ---
# Set a VNC password (highly recommended, replace 'yourvncpassword' with a strong one)
# For a lab, a simple one is fine.
ENV VNC_PASSWORD=yourvncpassword123
RUN mkdir -p ~/.vnc \
    && echo "${VNC_PASSWORD}" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 ~/.vnc/passwd

# Expose VNC port
EXPOSE 5900

# Create a script to start Xvnc, fluxbox, and Firefox
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
