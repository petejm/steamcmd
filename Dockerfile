########################################
# Dockerfile for Ubuntu SteamCMD
########################################
FROM ubuntu:18.04
LABEL maintainer="rocket859@gmail.com"

# Do the beginning Install and Configure of Packages
RUN apt update && apt install -y \
lib32stdc++6 \
lib32gcc1 \
sudo \
curl && \
apt -y upgrade && \
apt autoclean && apt autoremove && \
# Make a user with the name steam
useradd -m steam && \
# Add the steam user to Sudoers File
usermod -aG sudo steam

# Modify Sudoers to not prompt for password
RUN echo "steam ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the user steam
USER steam

# Create SteamCMD Directory
RUN mkdir -p /home/steam/steamcmd && cd /home/steam/steamcmd && \
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Create steamCMD Volume
VOLUME /home/steam/steamcmd
