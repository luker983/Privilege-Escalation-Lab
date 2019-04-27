# Linux Privilege Escalation
#### Luke Rindels - April 2019

## Introduction
Initial exploitation of a machine usually involves gaining access to a
low-privileged user. This lab focuses on using that initial foothold to exploit
a poorly administered system. You will be given credentials for a highly 
restricted user account and must use what little tools you have at your
disposal to elevate your privileges.

This document will walk you through the steps needed to gain access to a user
named *level1*, then *level2*, and finally *root*, but you are encouraged to 
find your own exploits and work-arounds to the restrictions put in place. If 
this lab has already been set up by an instructor, you may proceed to the
*Accessing the Lab Container* section.

## Getting Started

###  Docker

#### Build Image
Build a Docker image by running the following command, assuming that
the Dockerfile is in your current working directory:
```
docker build -t privesc .
``` 
This will create a new image with the name *privesc*. To verify, run: 
```
docker images | grep privesc
``` 

#### Start Container
The *privesc* image can now be used to start a container:
```
docker run --name privesc_lab -id privesc
``` 
`--name` allows us to choose a container name. A name will be generated if this
option is not used.

`-i` keeps stdin open, allowing for the container to stay running while it is 
in the background.

`-d` runs the container in the background.

To verify, run:
```
docker ps | grep privesc_lab
```

### Accessing the Lab Container
The container exposes SSH on port 22. To get the IP address of the container 
with the name *privesc_lab*, run:
```
docker inspect privesc_lab | grep IPAddress
```
Assuming that the IP address output is `172.17.0.1`, you may access the 
container with:
```
ssh level0@172.17.0.1
```
The credentials for the *level0* user are:
```
level0:password
```

## Escalation

### Cron
The first thing you might notice is that the *level0* user has an extremely
restricted shell. To see what shell you're running in:
```
echo $0
```
Very little can be done in this state, but you may notice that there is a 
`monitor.sh` script in the *level0* home directory owned by *level1*. Another
file named `monitor.out` in the same directory is being updated occasionally.
This is a sign that cron is being used.

Cron is a time-based job scheduler used for automating system tasks. When it
is improperly used it can become an entry-point for escalating privileges. Cron
jobs are stored in many different places, but for our purposes lets start by
looking in `/etc/crontab`. Look for a job that executes the `monitor.sh`
script.

It would be ideal to modify the `monitor.sh` script in order to execute another
command, but *level0* does not have write permissions on that file. Instead,
the solution is to rename `monitor.sh` to something else and then upload a
custom script with the name `monitor.sh`. The cron job will then execute your
custom script instead of the original script, essentially allowing you to run 
commands as *level1*. 

Once you are able to run commands as *level1*, look for things that might be
unique to *level1*. Perhaps there is an SSH key in their home directory or an
email that contains some personal information.

```
1. What is the default shell for the level0 user?
2. What was your final exploit script to get level1 credentials?
3. What are the level1 credentials?
```

### Configurations

### SUID
