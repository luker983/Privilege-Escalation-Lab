# Source image
FROM ubuntu:18.04

# Update, upgrade, and install necessary packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install openssl -y
RUN apt-get install ssh -y

# Setup users
RUN echo "root:IAMR00T" | chpasswd
RUN useradd -ms /bin/rbash -p $(openssl passwd -1 password) level0
RUN useradd -ms /bin/sh -p $(openssl passwd -1 ThisIsThePasswordForLevel1) level1
RUN useradd -ms /bin/bash -p $(openssl passwd -1 L3v3l2!) level2

# Expose SSH port and start service
EXPOSE 22
ENTRYPOINT service ssh restart && bash
