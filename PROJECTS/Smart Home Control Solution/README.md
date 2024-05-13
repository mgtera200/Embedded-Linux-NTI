# Smart Home Control Solution

## Overview
The Smart Home Control Solution is a comprehensive system designed to provide seamless control and monitoring of various smart home devices. Leveraging a Raspberry Pi 4 and Yocto-generated customized Linux Sato image, this project integrates platform device drivers, C++ applications, IoT functionality, SystemV scripts, Qt6 GUI applications, and Yocto Project capabilities to create a robust smart home control ecosystem.

## Features

### 1. Platform Device Driver
- Configured to be compatible with 9 devices: redled, redled2, redled3, buzzer, button, firesensor, smokesensor, switch1, and switch2.
- Configured in the device tree (DTB) file of the Raspberry Pi 4.

### 2. C++ App [Button <-> Led]
- Monitors the LED based on the status of the switch.

### 3. IoT Applications
- Python applications connected to Google's Firebase server.
- Monitor devices and respond to changes made remotely via the mobile app connected to the server.

### 4. SystemV Scripts
- Used to bring up all applications in the background upon Raspberry Pi 4 boot.
- Ensures smooth execution and operation of the smart home control system.

### 5. Qt6 Application
- GUI application for local user interaction with smart home devices.
- Provides an intuitive interface for device control and monitoring.

### 6. Yocto Project
- Used to generate a customized Linux Sato image tailored to support this project.
- Includes necessary libraries, GUI, and Qt6 libraries for seamless integration and functionality.
