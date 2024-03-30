# Using SSH to Connect to Vexpress Board on QEMU with Buildroot

This guide outlines the steps to use SSH on your host machine to connect to a Vexpress board running on QEMU with Buildroot.

## Step 1: Edit QEMU Start Script:

Navigate to the directory where QEMU images are located:

```bash
cd ~/buildroot-2024.02/output/images
```
Edit the `start-qemu.sh` script:

```bash
sudo vim start-qemu.sh
```
Modify the `qemu-system-arm` command to include necessary parameters for running the Vexpress board with appropriate options such as memory size, kernel image, device tree blob, root filesystem, networking, etc.

```bash
qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel zImage -dtb vexpress-v2p-ca9.dtb -drive file=rootfs.ext2,if=sd,format=raw -append "console=ttyAMA0,115200 rootwait root=/dev/mmcblk0" -net nic,model=lan9118 -net tap,script=/home/eng-tera/sdCard/tftp_bash
```

## Step 2: Run QEMU:

Execute the modified `start-qemu.sh` script with sudo:

```bash
sudo ./start-qemu.sh
```

## Step 3: Set IP Address on Vexpress Board:**

Once the kernel has started in QEMU, set the IP address of eth0 on the Vexpress board:

```bash
ip add a 100.101.102.102/24 dev eth0
```

## Step 4: Connect to Vexpress Board via SSH:**

On the host terminal, use SSH to connect to the Vexpress board:

```bash
ssh root@100.101.102.102
```

## Successful SSH Connection:**

You have successfully connected to the Vexpress board running on QEMU with Buildroot using SSH.

## Notes:

- Ensure that the necessary networking configurations are correctly set up in the QEMU command and the networking script (`/home/eng-tera/sdCard/tftp_bash`)

tftp_bash Script:
```bash
#!/bin/sh
ip a add 100.101.102.100/24 dev $1
ip link set $1 up
```
