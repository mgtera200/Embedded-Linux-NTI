# Setting Up Daemon Applications with System V Init on Buildroot for QEMU

## Overview
This guide outlines the steps to set up daemon applications on a vexpress board emulated with QEMU using Buildroot with System V init as the init process.

## Prerequisites
- Buildroot setup for vexpress board
- QEMU installed
- Basic knowledge of System V init scripts

## Steps

## 1) Customize Buildroot Image:

   - Configure Buildroot to generate an image for the vexpress board.
   - Include necessary packages/tools for development and testing.

## 2) Configure System V Init:
   - Set up Buildroot to use System V init as the init process.
   - Ensure that the appropriate settings are configured in Buildroot's configuration.

## 3) Edit `inittab` File:
   - Add runlevel entries to the `/etc/inittab` file for managing daemon applications.
   - Add the following lines:
```plaintext
     ter1:1:wait:/etc/init.d/rc 1
     ter2:2:wait:/etc/init.d/rc 2
     ter3:3:wait:/etc/init.d/rc 3
     ter4:4:wait:/etc/init.d/rc 4
     ter5:5:wait:/etc/init.d/rc 5
```
## 4) Create Daemon Applications:

   - Create daemon application executables in `/bin` which will be turned on or off by the Init Scripts.
   - Example daemon application (`/bin/daemonapp`):
```bash
     #!/bin/sh
     while true
     do
         echo "Daemonapp is running!" >> /tmp/daemon.test
         sleep 10
     done
```
     
## 5) Create Init Scripts:

   - Create directories for each runlevel (`rc1.d`, `rc2.d`, etc.) under `/etc/init.d`.
   - Create daemon application scripts to manipulate the daemon applications based on the input arguments.
   - Example script (`/etc/init.d/daemonapp`):
```bash
     #!/bin/sh
     case "$1" in
       start)
            echo "Starting daemonapp..."
            start-stop-daemon -S -n daemonapp -a /bin/daemonapp &
            ;;
       stop)
            echo "Stopping daemonapp..."
            start-stop-daemon -K -n daemonapp -a /bin/daemonapp
            ;;
       *)
            echo "Usage: $0 {start|stop}"
            exit 1
     esac
     exit 0
```
_Note: start-stop-daemon is a helper function that makes it easier to manipulate background processes such as this. It originally came from the Debian installer package, dpkg, but most embedded systems use the one from BusyBox. It starts the daemon with the -S parameter, making sure that there is never more than one instance running at any one time. To stop a daemon, you use the -K parameter, which causes it to send a signal, SIGTERM by default, to indicate to the daemon that it is time to terminate._

## 6) Create Symbolic Links:
   - Create symbolic links in the runlevel directories (`rc1.d`, `rc2.d`, etc.) to whatever the init scripts you want.
   - Use appropriate naming conventions (`S##` for start scripts, `K##` for kill/stop scripts).
   - Example symbolic link (`/etc/init.d/rc2.d/S01daemonapp`):
```bash
     ln -s /etc/init.d/daemonapp /etc/init.d/rc2.d/S01daemonapp
```


## 7) Create `rc` Script:

   - Create an `rc` script that executes the Symbolic Links in the runlevel directories based on the runlevel. The `rc` script begins by executing symbolic links starting with `K` with an order from the lower number written after `K` to the higher number, Passing to them `stop` argument. It then proceeds to execute symbolic links starting with `S`, Passing to them `start` argument with the same order mechanism.
   - Example script (`/etc/init.d/rc`):
```bash
     #!/bin/bash

     # Check if one argument is provided
     if [ $# -ne 1 ]; then
         echo "Usage: $0 <runlevel>"
         exit 1
     fi

     # Define the folder path based on the argument
     folder="rc$1.d"

     # Kill scripts starting with K
     for i in /etc/init.d/$folder/K??* ;do

          # Ignore dangling symlinks (if any).
          [ ! -f "$i" ] && continue

          case "$i" in
             *.sh)
                 # Source shell script for speed.
                 (
                     trap - INT QUIT TSTP
                     set stop
                     . $i
                 )
                 ;;
             *)
                 # No sh extension, so fork subprocess.
                 $i stop
                 ;;
         esac
     done

     # Start scripts starting with S
     for i in /etc/init.d/$folder/S??* ;do

          # Ignore dangling symlinks (if any).
          [ ! -f "$i" ] && continue

          case "$i" in
             *.sh)
                 # Source shell script for speed.
                 (
                     trap - INT QUIT TSTP
                     set start
                     . $i
                 )
                 ;;
             *)
                 # No sh extension, so fork subprocess.
                 $i start
                 ;;
         esac
     done
```

## 8) Test:
   - Boot QEMU with the custom Buildroot image.
   - Verify that the daemon applications start and stop correctly when switching runlevels or using the `init` command.

## 9) Troubleshooting:
   - Check log files for any errors (`/var/log/messages`, etc.).
   - Ensure correct permissions and paths for scripts and executables.

