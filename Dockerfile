FROM ubuntu:18.04

RUN apt update && apt upgrade

RUN useradd -ms /bin/rbash -p $(openssl passwd -1 password) level0
RUN useradd -ms /bin/sh -p $(openssl passwd -1 pA$$w0rd!) level1
RUN useradd -ms /bin/bash -p $(openssl passwd -1 sWm7$SF$R%e) level2


EXPOSE 22
