# BuildRoot Setup and Configuration Guide

## Download Required Libraries

```bash
sudo apt install sed make binutils gcc g++ bash patch \
gzip bzip2 perl tar cpio python unzip rsync wget libncurses-dev
```
---

## Download BuildRoot

```bash
wget https://buildroot.org/downloads/buildroot-2024.02.tar.gz

tar -xvzf buildroot-2024.02.tar.gz
```
---

## Configuration

List Supported Board Configurations:

```bash
make list-defconfigs
```

Or view files inside:
```bash
ls configs/
```

Configure Qemu Vexpress:

```bash
make qemu_arm_vexpress_defconfig
```

Configure buildroot:

```bash
make menuconfig
```

In the configuration, ensure the following requirements are met:

- Init procecss to **System V** or **System D** or **Busybox init**
	- _Note: For systemd, increase the root filesystem size from Buildroot configuration._
- Change **system host**
- Change **system banner**
- Apply **root password**

Configure SSH:

To configure SSH and add the executable in rootfs in Buildroot:

- Enable in **Network application** configure **dropbear**
- Set **Root password** in **system configuration**

---

## Build the System

```bash
# # Build Buildroot, register logs for debugging
make 2>&1 | tee build.log

```

---

## Configure Embedded Linux Component

Configure Linux:

```bash
# to change configuration for linux 
make linux-menuconfig
```

Configure uboot:

```bash
# to configure uboot
make uboot-menuconfig
```

Configure Busybox:

```bash
# to configure busybox
make busybox-menuconfig
```

---

## Boot The System

Qemu:

```bash
cd ~/buildroot-2024.02/output/images 
```

```bash
./start-qemu.sh
```
---

# Adding a Custom Package to Buildroot and Testing on QEMU

## Objective:
The objective of this task is to add a custom package containing a simple "Hello, world!" program to Buildroot and test it on QEMU.

---

## Prepare Your Package Source:

Create a directory for your package source, e.g., `my_package` under ~/buildroot-2024.02/packages:
```bash
mkdir my_package ~/buildroot-2024.02/package
```
Place your source file (e.g., `hello_world.c`) inside this directory:
```bash
cd ~/buildroot-2024.02/package/my_package
touch hello_world.c
```

Insert your Code:
```bash
vim hello_world.c
---

```bash
#include <stdio.h>

int main() {
    printf("Hello, world!\n");
    return 0;
}
```

## Create a Buildroot Package Configuration:

Inside the `my_package` directory, create a `Config.in` file to define configuration options for your package:

```bash
touch Config.in
```

```bash
vim Config.in
```
Then inside `Config.in` file insert these lines:
```bash
config BR2_PACKAGE_MY_PACKAGE
    bool "my_package"
    help
      Hello World Package
```
---

## Create a Buildroot Makefile for Your Package:

Create a `my_package.mk` file in the `my_package` directory:
```bash
touch my_package.mk
```

```bash
vim my_package.mk
```
This file should contain metadata and build instructions for your package:

```bash
################################################################################
#
# my_package
#
################################################################################

MY_PACKAGE_VERSION = 1.0
MY_PACKAGE_SITE = $(TOPDIR)/package/my_package
MY_PACKAGE_SITE_METHOD = local

define MY_PACKAGE_BUILD_CMDS
    $(TARGET_CC) $(TARGET_CFLAGS) -o $(@D)/hello_world $(@D)/hello_world.c
endef

define MY_PACKAGE_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 755 $(@D)/hello_world $(TARGET_DIR)/usr/bin/hello_world
endef

$(eval $(generic-package))
```
---

## Edit the configuration file of BuildRoot

Under `package` directory open `Config.in` file:

```bash
vim ~/buildroot-2024.02/package/Config.in
```
Edit `Config.in` content by adding these lines under `Target Package` line inside the file:

```bash
menu "my_package Packages"
    source "package/my_package/Config.in"
endmenu

```

---

## Configure Buildroot:

   - Run `make menuconfig` in the Buildroot directory.
   - Navigate to `Target packages` and select your package.
   - Enable your package for the target architecture (e.g., vexpress) and any necessary dependencies.

---

## Build Buildroot:

   - After configuring, exit `menuconfig` and save your configuration.
   - Run `make` to build Buildroot with your package included.

---

## Test on QEMU:
   - Once the build is complete, test it on QEMU.

---

## Verify Your Package:

   - Upon booting QEMU with the custom Buildroot image, verify that your package is installed and functions correctly within the QEMU environment.

---

## Conclusion:
By following these steps, you've successfully added a custom package to Buildroot and tested it on QEMU.

