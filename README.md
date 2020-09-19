This is a Windows Batch script that helps with using SSH bookmarks in a simple text file.

# Features

Quickly searching and selecting an SSH host from a bookmark text file, then
 - Starting a command line SSH session.
 - Mounting SFTP shares in Windows Explorer using SSHFS-win.

The bookmark list by default is stored in `ssh-hosts.txt` file located in the script directory.

This script accepts SSH bookmarks textfile path as it's first parameter e.g. `.\sshb.bat "D:\ssh\ssh-hosts.txt"`.

# `ssh-hosts.txt`

```
user@host[:/remote-path] [keyfile-path] [port-number] [short-descriptive-name]
```

e.g.

```
dev@example.com:/var/log ~/.ssh/dev_server - -
sales@example.com:/home/sales/work-files ~/.ssh/id_rsa - sales
terry@192.168.111.112 - 23 terrys-computer
...
```

Parameters `keyfile-path`, `port-number`, `short-descriptive-name` are replaced with `-` if not intended to be set.

# Requirements 

- <a href="https://github.com/junegunn/fzf">`fzf`</a> to display and search through SSH bookmarks textfile.
- <a href="https://github.com/billziss-gh/sshfs-win">`sshfs-win`</a>  to mount SFTP shares in Windows Explorer.

# License

MIT
