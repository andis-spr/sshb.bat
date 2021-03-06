@SETLOCAL
@ECHO OFF

:: Set path for sshfs-win executable
set PATH="%SYSTEMDRIVE%\Program Files\SSHFS-Win\bin";%PATH%

goto START

:START
cls

:: Set SSH hosts list file
if "%1"=="" (
   if exist "%USERPROFILE%\ssh-hosts.txt" (
      call set SSH_HOSTS_FILE=%USERPROFILE%\ssh-hosts.txt
   ) else (
      call set SSH_HOSTS_FILE=%~dp0\example.ssh-hosts.txt
   )
) else (
   call set SSH_HOSTS_FILE=%1
)

title %SSH_HOSTS_FILE%

:: Pick host line from text file
for /F "tokens=*" %%g in ('type %SSH_HOSTS_FILE% ^| fzf --cycle --layout="reverse-list"') do (set HOST_LINE=%%g)

if "%HOST_LINE%"=="" (
   call goto :eof
)

:: Seperate user, host address, directory path and keyfile from host line in variables
for /f "tokens=1,2,3,4 delims= " %%a in ("%HOST_LINE%") do (
   set LABEL=%%a
   set USER_HOSTADDR_DIRPATH=%%b
   set KEYFILE=%%c
   set PORT=%%d
)

for /f "tokens=1,2 delims=:" %%a in ("%USER_HOSTADDR_DIRPATH%") do (
   set DIRPATH=%%b
)

for /f "tokens=1,2 delims=@" %%a in ("%USER_HOSTADDR_DIRPATH%") do (
   set USER=%%a
   set HOSTADDR_DIRPATH=%%b
)

for /f "tokens=1,2 delims=:" %%a in ("%HOSTADDR_DIRPATH%") do (
   set HOSTADDR=%%a
)

:: Set the directory path if not provided
if "%DIRPATH%"=="" (set DIRPATH="/")

:: Check for presence of actual keyfile value

set IS_KEYFILE="true"

if "%KEYFILE%"=="" (
   set IS_KEYFILE="false"
)

if "%KEYFILE%"=="-" (
   set IS_KEYFILE="false"
)

:: Check if a custom port number has been set

set IS_CUSTOM_PORT="true"

if "%PORT%"=="" (
   set IS_CUSTOM_PORT="false"
)

if "%PORT%"=="-" (
   set IS_CUSTOM_PORT="false"
)

:: Check if a label has been set

set IS_LABEL="true"

if "%LABEL%"=="" (
   set IS_LABEL="false"
)

if "%LABEL%"=="-" (
   set IS_LABEL="false"
)

if %IS_LABEL%=="false" (
   set LABEL=%USER%@%HOSTADDR%
) 

set LABEL=%LABEL%:%DIRPATH%

:: Show the action selection menu
:MENU
title %LABEL%
echo.
echo  %LABEL%
echo.
echo   User: %USER%
echo   Host: %HOSTADDR%
echo   Directory: %DIRPATH%
if %IS_CUSTOM_PORT%=="true" (
   call echo   Custom port: %PORT%
)
echo   Keyfile:  %KEYFILE%
echo.
echo   Choose a task:
echo.
echo    1 - SSH session
echo    2 - SSHFS mounting
echo.
echo    Enter - back to %SSH_HOSTS_FILE%
echo.
echo    q - Exit
echo.
set "M="
set /p M=" Task > " || goto START

if %M%==1 (goto SSH) ^
else if %M%==2 (goto SSHFSWIN) ^
else if %M%==q (goto EOF) ^
else if %M%==Q (goto EOF) ^
else (
   cls
   call echo.
   call echo  Invalid task mapping: %M%
   goto MENU
)

:: Start SSH terminal session
:SSH
set SSH_CMD=ssh %USER%@%HOSTADDR%

if %IS_KEYFILE%=="true" (
   call set SSH_CMD=%SSH_CMD% -i %KEYFILE%
)

if %IS_CUSTOM_PORT%=="true" (
   call set SSH_CMD=%SSH_CMD% -p %PORT%
)
echo.
echo Connecting to %HOSTADDR%...
echo.
%SSH_CMD%
goto MENU

:SSHFSWIN

:: Pick an unused drive letter
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) ^
do @%%i: 2>nul || ^
if not defined UNUSED_DRIVE_LETTERS (call set "UNUSED_DRIVE_LETTERS=%%i" <nul) ^
else (call set "UNUSED_DRIVE_LETTERS=%%UNUSED_DRIVE_LETTERS%% %%i" <nul)

for %%h in (%UNUSED_DRIVE_LETTERS%) ^
do set "FIRST_UNUSED_DRIVE_LETTER=%%h" & goto done
:done

:: Start SSHFS-win session
set VOLNAME=sshfs:%LABEL:~0,25%

set SSHFS_CMD=sshfs ^
-f ^
%USER%@%HOSTADDR%:%DIRPATH% %FIRST_UNUSED_DRIVE_LETTER%: ^
-o ^
ssh_command="/bin/ssh.exe -vvv",^
create_file_umask=0111,^
create_dir_umask=0000,^
umask=0000,^
uid=-1,^
gid=-1,^
idmap=user,^
volname=%VOLNAME%

if %IS_KEYFILE%=="true" (
   call set SSHFS_CMD=%SSHFS_CMD%,-i=%KEYFILE%
)
echo.
echo Drive letter "%FIRST_UNUSED_DRIVE_LETTER%:" assigned as mount point with the volume name "%VOLNAME%"
echo.
echo Connecting to %HOSTADDR%...
echo.
title sshfs %FIRST_UNUSED_DRIVE_LETTER%: %LABEL%
%SSHFS_CMD%
goto MENU
:EOF
title Command Prompt
