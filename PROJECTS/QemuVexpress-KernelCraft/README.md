# QemuVexpress-KernelCraft Project - [ [ Project Video ] ](https://drive.google.com/file/d/158cRNEEM9KCw2eNmoWurR6eS1SauR_vy/view?usp=sharing)

The QemuVexpress-KernelCraft Project is a comprehensive endeavor aimed at customizing and deploying a tailored Linux kernel on the ARM Cortex-A9-based Vexpress board using the QEMU emulator. This project encompasses various stages, including toolchain customization, bootloader configuration, kernel compilation, root filesystem setup, system initialization, and booting the kernel on the board.

## Custom ARM Toolchain Setup:

A specialized ARM toolchain tailored for the Cortex-A9 architecture was configured to ensure compatibility and optimal performance, The setup process can be found -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/03-%20Toolchain%20Customization).


## Custom U-Boot Configuration:

The U-Boot bootloader was customized to facilitate the boot process and interact with the hardware components of the Vexpress board effectively, The step-by-step guide is documented -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/04-%20U-Boot%20Customization).


## Kernel Image and Device Tree Blob (DTB) Customization:

Detailed instructions for configuring the kernel image and Device Tree Blob (DTB) to accurately describe the hardware components of the Vexpress board can be found -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/06-%20Kernel%20Customization).


## Root File System Generation and Init Process Configuration:

Documentation for generating the root file system using BusyBox, customizing it to provide essential utilities and libraries, and configuring the initialization process through the `/etc/inittab` file and executing the `rcS` script is available -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/07-%20Busybox%20Customization).

## Booting on the Board:

The customized kernel was successfully booted on the Vexpress board using the QEMU emulator, demonstrating the functionality and compatibility of the tailored setup. Shell access was achieved, and a user was created on the kernel, as showcased in the Project Video.

---

This project represents a meticulous effort to optimize the Linux kernel for the Vexpress board, showcasing the versatility and adaptability of embedded Linux systems in diverse environments.

