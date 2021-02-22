# `sshb.bat`

<img src="https://i.imgur.com/Rb4JAAK.png" />

Windows script for using SSH bookmarks stored in a text file.

## Features

Find and select an SSH bookmark to
 - start SSH session in Windows command line
 - mount SSHFS directories in Windows Explorer using <a href="https://github.com/billziss-gh/sshfs-win">SSHFS-Win</a>

## `ssh-hosts.txt`

The default SSH bookmark list is located in the `%USERPROFILE%\ssh-hosts.txt` file.

This script accepts SSH bookmarks text file path as it's first parameter e.g. `.\sshb.bat "D:\ssh\ssh-hosts.txt"`.

### Bookmarks format

```
[label] user@host[:/remote-path] [keyfile-path] [port-number]
```

e.g.

```
terrys-computer terry@192.168.111.112 - 22
home-router root@192.168.2.1:/etc ~/.ssh/homerouter 23
...
```

Parameters `label`, `keyfile-path`, `port-number` can omited by replacing them with the `-` value.

## Requirements 

- <a href="https://github.com/junegunn/fzf">fzf</a>
- <a href="https://github.com/billziss-gh/sshfs-win">SSHFS-Win</a>
- <a href="https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_overview">OpenSSH</a> (included by default with Windows 10)

## License

MIT
