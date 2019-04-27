# Source image
FROM ubuntu:18.04

# Update, upgrade, and install necessary packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install openssl -y
RUN apt-get install ssh -y
RUN apt-get install vim -y
RUN apt-get install nano -y
RUN apt-get install cron -y

# Setup users
RUN echo "root:IAMR00T" | chpasswd
RUN useradd -ms /bin/rbash -p $(openssl passwd -1 password) level0
RUN useradd -ms /bin/sh -p $(openssl passwd -1 ThisIsThePasswordForLevel1) level1
RUN useradd -ms /bin/bash -p $(openssl passwd -1 L3v3l2!) level2

# Restrict level0 account
COPY profile /home/level0/.profile
RUN mkdir /home/level0/.bin
RUN ln -s /bin/ls /home/level0/.bin
RUN ln -s /bin/cat /home/level0/.bin
RUN ln -s /bin/echo /home/level0/.bin
RUN ln -s /bin/mv /home/level0/.bin
RUN ln -s /bin/chmod /home/level0/.bin

# level1 exploit
COPY monitor.sh /home/level0/monitor.sh
RUN chown level1:level1 /home/level0/monitor.sh
RUN usermod -a -G level0 level1
RUN chmod 775 /home/level0
RUN echo "* * * * * level1 bash /home/level0/monitor.sh > /home/level0/monitor.out" >> /etc/crontab
RUN echo "ThisIsThePasswordForLevel1" > /home/level1/password.backup
RUN chown level1:level1 /home/level1/password.backup
RUN chmod 660 /home/level1/password.backup

# level2 exploit
COPY bash_history /home/level1/.bash_history

# level3 exploit
RUN chgrp level2 /usr/bin/vim.basic
RUN chmod 4770 /usr/bin/vim.basic

# Expose SSH port and start services
EXPOSE 22
ENTRYPOINT service ssh restart && service cron restart && bash
