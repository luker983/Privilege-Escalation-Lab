# Linux Privilege Escalation
#### Luke Rindels - April 2019

## Introduction
Initial exploitation of a machine usually involves gaining access to a
low-privileged user. That's great and a lot of information can be gleaned from
a user account, but higher levels of access allow for complete ownership of a
machine. In this lab you will be given credentials for a very low level user
on a docker container. From the low level user you will be able to exploit
poorly setup systems up a chain of increasing levels of privilege to eventually 
gain root. to higher levels of Hopefully learning about how attackers elevate 
privileges you will be better prepared to harden a system in the future. 

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

### Configurations

### SUID
