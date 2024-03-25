# Customizing Root File System with BusyBox for ARM Cortex-A9 on Vexpress [ Qemu ]

BusyBox is a versatile software suite providing compact implementations of several standard Unix utilities. It's commonly used in embedded systems and environments with limited resources due to its small size and efficiency.

## Downloading BusyBox

Clone the BusyBox repository from the official source:

```bash
git clone https://github.com/mirror/busybox.git
cd busybox/
```
---

## Configuring BusyBox

Use menuconfig to configure BusyBox according to your requirements:


```bash
make menuconfig
```
---

## Compiling BusyBox

Export the compiler and architecture variables:

```bash
export CROSS_COMPILE=Path/arm-cortexa9_neon-linux-musleabihf-
export ARCH=arm
```
Configure BusyBox for static build:
```bash
make menuconfig
```

Build BusyBox:
```bash
make
```
Generate the rootfs
```bash
make install
```
This will create folder named _install which has all binaries

---

## Creating the Root File System


Set up the root filesystem by copying BusyBox binaries:

```bash
# to go out from busybox directory
cd ..

# create directory rootfs
mkdir rootfs

# copy the content inside the _install into rootfs
cp -rp ./busybox/_install/ ./rootfs

# change directory to rootfs
cd rootfs

# create the rest folder for rootfs
mkdir -p ./dev ./etc

#create folder inittab
touch ./etc/inittab
```

---

## Mounting RootFS via SD Card

Mounting SDcard using my bash script **" bashscript_SDcardMount "** :
```bash
#!/usr/bin/bash

DISK=$(sudo losetup -f --show --partscan ~/sdCard/sd.img)

export DISK

if sudo mount ${DISK}p1 ~/sdCard/sd; then
echo "<Eng.TERA Message> Mounting p1 to sd is done Successfully!"
fi

if sudo mount ${DISK}p2 ~/sdCard/sd2; then
echo "<Eng.TERA Message> Mounting p2 to sd is done Successfully!"
fi

bash
```

Copy the root filesystem to the SD card:


```bash
cd rootfs
cp -r * ~/sdCard/sd2
```
Unmount the SD card using my bash script **" bashscript_SDcardUmount "** :

```bash
#!/bin/bash

if [ $# -ne 1 ]; then
echo "Please enter your arguments as: $0 </dev/loop>"
exit 1
fi

DISK="$1"

sudo umount ~/sdCard/sd
sudo umount ~/sdCard/sd2

sudo losetup -d "$DISK"
```

---


## Configuring Inittab

We need to setup " inittab " file because it's the first thing that the **init** process look at

```bash
# inittab file 
::sysinit:/etc/init.d/rcS

# Start an "askfirst" shell on the console (whatever that may be)
ttyAMA0::askfirst:-/bin/sh

# Stuff to do when restarting the init process
::restart:/sbin/init
```

---

## Create `/etc/init.d/rcS` startup script

- The first user space program that gets executed by the kernel is `/sbin/init` and its configuration
file is `/etc/inittab`. 

- In `inittab` we are executing `::sysinit:/etc/init.d/rcS`but this file doesn't exist.

```sh 
#!/bin/sh

# mount a filesystem of type `proc` to /proc
mount -t proc nodev /proc

# mount a filesystem of type `sysfs` to /sys
mount -t sysfs nodev /sys

```

**Ensure execution permission for the rcS script:**

```sh
#inside `rootfs` folder
chmod +x ./etc/init.d/rcS # to give execution permission for rcS script
```
