# `win-ssh-bookmarks`

Windows script for using SSH bookmarks stored in a text file.

## Preview

<img src="https://i.imgur.com/Rb4JAAK.png" />

## Features

Find and select an SSH host stored in a text file, then
 - start an SSH session in Windows command line,
 - or mount SSHFS directories in Windows Explorer via SSHFS-win.

## `ssh-hosts.txt`

The bookmark list by default is stored in the `%USERPROFILE%\ssh-hosts.txt` file.

This script accepts SSH bookmarks textfile path as it's first parameter e.g. `.\sshb.bat "D:\ssh\ssh-hosts.txt"`.

### Format

```
[label] user@host[:/remote-path] [keyfile-path] [port-number]
```

e.g.

```
terrys-computer terry@192.168.111.112 - 22
home-router root@192.168.2.1:/etc ~/.ssh/homerouter 23
...
```

Parameters `label`, `keyfile-path`, `port-number` can be replaced with a default `-` value.

## Requirements 

- <a href="https://github.com/junegunn/fzf">`fzf`</a> to display and search through SSH bookmarks textfile.
- <a href="https://github.com/billziss-gh/sshfs-win">`sshfs-win`</a>  to mount SSHFS directories in Windows Explorer.

## License

MIT
