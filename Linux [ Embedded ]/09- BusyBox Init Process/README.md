# Implementing Custom Daemon App with BusyBox Init Process

## Objective:
In this lab, we will utilize the BusyBox init process to run a custom daemon application in the background. Participants will gain hands-on experience in configuring the system initialization process and managing daemon processes using BusyBox.

## Step 1: Prepare the System:
   - Mount the SD card and navigate to the root filesystem.

## Step 2: Edit inittab File:
   - Open the `/etc/inittab` file and configure the system initialization process:
```bash
     # Mount proc and sys filesystems
     null::sysinit:/bin/mount -t proc proc /proc
     null::sysinit:/bin/mount -t sysfs sysfs /sys

     # Execute when the system starts
     ::sysinit:/etc/init.d/rcS

     # Prompt to enter the shell
     console::askfirst:-/bin/sh

     # Execute when the system shuts down
     ::shutdown:/etc/init.d/rcK
```

## Step 3: Edit rcS Script:
   - Modify the `/etc/init.d/rcS` script to start the daemon application:
```bash
     #!/bin/sh
     echo "Initializing rcS..."
     daemonapp &
```

# Step 4: Edit rcK Script:
   - Modify the `/etc/init.d/rcK` script to stop the daemon application gracefully:
```bash
     echo "Shutting down rcK..."
     pkill -e daemonapp
     sleep 3
```

## Step 5: Create Daemon App:
   - Create the `daemonapp` script in `/usr/bin` to define the behavior of the daemon application:
```bash
     #!/bin/sh
     while true 
     do 
         date >> /tmp/daemon.test
         sleep 10
     done
```

## Step 6: Run QEMU Virtual Machine:
   - Execute the QEMU virtual machine using the provided script `bashscript_QemuStartUboot`:
```bash
#!/usr/bin/bash

if [ $# -ne 3 ]; then
echo "Please enter your arguments as: $0 <PATH/u-boot/u-boot> <PATH/sd.img> <PATH/tap_script>"
exit 1
fi

PATH_for_uboot_uboot="$1"
PATH_for_sd_img="$2"
PATH_for_tap_script="$3"

if [ ! -f "$PATH_for_uboot_uboot" ]; then 
echo "Error: u-boot file '$PATH_for_uboot_uboot' not found."
exit 1
fi

if [ ! -f "$PATH_for_sd_img" ]; then 
echo "Error: sd.img '$PATH_for_sd_img' not found."
exit 1
fi

if [ ! -f "$PATH_for_tap_script" ]; then 
echo "Error: tap script '$PATH_for_tap_script' not found."
exit 1
fi

sudo qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel "$PATH_for_uboot_uboot" -sd "$PATH_for_sd_img" -net tap,script="$PATH_for_tap_script" -net nic
bash
```

## Step 7: Verify Daemon Functionality:
   - After booting the system, observe the initialization message "Initializing rcS...".
   - Verify the daemon application functionality by monitoring the log output:
```bash
     tail -f /tmp/daemon.test
```

## Step 8: Check Process ID:
   - Confirm the daemon application process is running using the `ps` command:
```bash
     ps -ef | grep daemonapp
```

## Conclusion:
Participants have successfully configured the BusyBox init process to manage a custom daemon application, demonstrating practical knowledge in system initialization and process management using BusyBox.


