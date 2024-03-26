# QemuVexpress-KernelCraft Project

The "QemuVexpress-KernelCraft Project" is a meticulously documented endeavor aimed at crafting a tailored Linux kernel environment for the ARM Cortex-A9 architecture. Each customization process has been meticulously documented step-by-step on GitHub, ensuring transparency, reproducibility, and accessibility for future developers and enthusiasts.

1. **Custom ARM Toolchain Setup:** Detailed documentation for the custom ARM toolchain setup process can be found -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/(2)%20Customized%20Toolchain).

2. **Custom U-Boot Configuration:** The step-by-step guide for configuring U-Boot to meet the specific requirements of the Vexpress board is documented -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/(3)%20Customized%20U-Boot).

3. **Kernel Image and Device Tree Blob (DTB) Customization:** Detailed instructions for configuring the kernel image and Device Tree Blob (DTB) to accurately describe the hardware components of the Vexpress board can be found -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/(4)%20Customized%20Kernel).

4. **Root File System Generation and Init Process Configuration:** Documentation for generating the root file system using BusyBox, customizing it to provide essential utilities and libraries, and configuring the initialization process through the `/etc/inittab` file and executing the `rcS` script is available -> [here](https://github.com/mgtera200/Embedded-Linux-NTI/tree/main/Linux%20%5B%20Embedded%20%5D/(5)%20Busybox).

Additionally, a comprehensive video demonstration showcasing the successful startup of the kernel on QEMU, user creation, and system initialization is available -> [here](https://drive.google.com/file/d/158cRNEEM9KCw2eNmoWurR6eS1SauR_vy/view?usp=sharing).

This approach ensures that all project documentation is easily accessible and serves as a valuable resource for developers and enthusiasts interested in replicating or extending the project's functionality.

