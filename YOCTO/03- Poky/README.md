# Poky

## Overview
Poky is a reference distribution of the OpenEmbedded build framework. It provides a starting point for creating custom Linux distributions for embedded systems. Poky includes a collection of recipes, configuration files, and tools necessary for building embedded Linux distributions.

## Generating an Image Using Poky and Running it on QEMU

## Steps

### Step 1: Setup Environment

Install the necessary dependencies and set up your development environment according to the Poky documentation.


### Step 2: Configure Poky

Customize Poky's configuration files and layers to define your target.

---

_Note: Step 1 and Step 2 can be done just by sourcing this script `oe-init-build-env`_
```bash
. oe-init-build-env
```
---

### Step 3: Build Image

Use BitBake to build the Linux image based on your configuration.

Example for minimal image:
```bash
bitbake -k core-image-minimal
```

### Step 4: Troubleshoot Errors

#### While building the image i had 5 Errors:

Error 1 `(perl_5.38.2.bb:do_package) Failed` To resolve it, run:

```bash
bitbake -c clean perl
```
Error 2 `(gnutls-3.8.3.bb:do_package) Failed` To resolve it, run:

```bash
bitbake -c clean gnutls
```
Error 3 `(linux-yocto_6.6.22+git.bb:do_compile) Failed` To resolve it, run:

```bash
bitbake -c clean linux-yocto
```
Error 4 `(llvm-native-18.1.2.bb:do_compile) Failed` To resolve it, run:

```bash
bitbake -c clean llvm-native
```
Error 5 `(util-linux-2.39.3.bb:do_configure) Failed` To resolve it, run:
```bash
bitbake -c clean util-linux
```
### Step 5: Rebuild Image

After cleaning the failed tasks, rebuild the image by running:

```bash
bitbake -k core-image-minimal
```
### Step 6: Run on QEMU:

Start a QEMU virtual machine and run the generated image to test its functionality. 

Run:
```bash 
runqemu qemux86-64
```

---

## Example Screenshot
![MostafaMohamedGamal](https://github.com/mgtera200/Embedded-Linux-NTI/assets/127119775/f5703db5-c445-4a24-b235-8b658db72a45)
