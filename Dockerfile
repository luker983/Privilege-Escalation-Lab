FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install openssl -y

RUN useradd -ms /bin/rbash -p $(openssl passwd -1 password) level0
RUN useradd -ms /bin/sh -p $(openssl passwd -1 ThisIsThePasswordForLevel1) level1
RUN useradd -ms /bin/bash -p $(openssl passwd -1 L3v3l2!) level2

EXPOSE 22
