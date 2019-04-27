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
restricted shell. To see what shell you're running in, run:
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

### Logs and Config Files
All it takes is one tiny mistake from a user to compromise a system. Keeping a
server up-to-date and functional is a difficult task, and sysadmins will
inevitably make an error. Enumerating through the many ways in which a password
might leak is a nice and easy way to either move laterally or gain access to 
another user. 

Many services like Apache and MySQL have plaintext passwords and keys in their
configuration files. Logs could also contain sensitive information. There are 
many great Linux enumeration cheat sheets and scripts available online that can
help automate this process. 

Everyone accidentally types in a password to a plaintext field at some point, 
and most systems keep a record of your bash history. Look for a mistake that
*level1* has made and use it to gain access to *level2*. 

```
4. What mistake did level1 make? 
5. What are the level2 credentials?
```

### SUID
Linux permissions can be confusing and it's tempting to choose convenience over
security. One of the most dangerous examples of this is the Set User ID bit. 
This is a special permissions bit that runs a program as the owner instead of 
the caller. To view all SUID enable programs that you have permissions to view, 
run:
```
find / -perm -4000 2>/dev/null
```
Special binaries like `sudo` and `passwd` use this bit to allow any user to
modify `/etc/shadow` entries without having root access. However, those
binaries authenticate. Programs that execute commands without authentication
are where the SUID bit can be exploited. For instance: `nmap` and `find` can 
be used to escalate privileges to the level of the owner (usually root) when
SUID is set.

Find what binaries have the SUID bit set and see if you can find one that does
not authenticate user commands. A good way to tell what shouldn't be there is
comparing the output of the `find` command with a personal machine. Use that
program to change the root password.

```
6. What program did you use to exploit an SUID bit?
7. How did you change the root password?
```
