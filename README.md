This is a Windows Batch script that helps using SSH bookmarks organized in a text file.

# Features

Quickly searching and selecting an SSH host from a bookmark text file, then
 - Starting a command line SSH session.
 - Mounting SSHFS directories in Windows Explorer using SSHFS-win.

# `ssh-hosts.txt`

The bookmark list by default is stored in `ssh-hosts.txt` file located in the script directory.

This script accepts SSH bookmarks textfile path as it's first parameter e.g. `.\sshb.bat "D:\ssh\ssh-hosts.txt"`.

## Format

```
[label] user@host[:/remote-path] [keyfile-path] [port-number]
```

e.g.

```
terrys-computer terry@192.168.111.112 - 22
home-router root@192.168.2.1:/etc ~/.ssh/homerouter 23
...
```

Parameters `label`, `keyfile-path`, `port-number` can be replaced with `-` for use of a default value.

# Requirements 

- <a href="https://github.com/junegunn/fzf">`fzf`</a> to display and search through SSH bookmarks textfile.
- <a href="https://github.com/billziss-gh/sshfs-win">`sshfs-win`</a>  to mount SSHFS directories in Windows Explorer.

# License

MIT
