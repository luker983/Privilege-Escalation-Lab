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

### Docker
Build a Docker image by running `docker build -it privesc .` in the same directory as the Dockerfile.
 
### Level 0 Credentials
Access the docker container using SSH.

Username: `level0`
Password: `password`

## Escalation

### Cron

### Configurations

### SUID
