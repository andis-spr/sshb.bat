# `win-ssh-bookmarks`

Windows script for using Secure Shell (SSH) bookmarks stored in a text file.

## Preview

<img src="https://i.imgur.com/Rb4JAAK.png" />

## Features

Find and select an SSH bookmark to
 - start a Secure Shell session in Windows command line (via OpenSSH)
 - mount SSHFS directories in Windows Explorer (via <a href="https://github.com/billziss-gh/sshfs-win">SSHFS-Win</a>)

## `ssh-hosts.txt`

The SSH bookmark list by default is located in the `%USERPROFILE%\ssh-hosts.txt` file.

This script accepts SSH bookmarks text file path as it's first parameter e.g. `.\sshb.bat "D:\ssh\ssh-hosts.txt"`.

### Format of storing the bookmarks

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

- <a href="https://github.com/junegunn/fzf">fzf</a> to display and search through SSH bookmarks textfile.
- <a href="https://github.com/billziss-gh/sshfs-win">SSHFS-Win</a>  to mount SSHFS directories in Windows Explorer.
- <a href="https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_overview">OpenSSH</a> (included by default in Windows 10).

## License

MIT
