# U-Boot Script execution Task

## Task Description:
The task involves creating a script that instructs U-Boot to attempt loading the Zimage file from a TFTP server first. If the loading from the TFTP server fails, then the script directs U-Boot to try loading from the FAT partition on the SD card.

## Solution Steps:


## 1) Create the U-Boot Script:
Develop a script named ubootScript_imageLoading with the necessary commands to first attempt loading the Zimage file from the TFTP server. If the loading from the TFTP server fails, instruct the script to try loading from the FAT partition in the SD card.

### ubootScript_imageLoading 
```bash
setenv ipaddr 100.101.102.102
setenv serverip 100.101.102.100

setenv LOAD_SUCCESS "false"

setenv LOAD_FROM_SERVER 'echo "Loading from Server.."; if tftp $kernel_addr_r Zimage; then echo "Loading from Server is DONE!"; bootz $kernel_addr_r $fdt_addr_r; else echo "Failed to load from Server!"; setenv LOAD_SUCCESS "true"; fi'

setenv LOAD_FROM_FAT 'echo "Loading from FAT.."; if "$LOAD_SUCCESS" != "true"; then if mmc dev; then if fatload mmc 0:1 $kernel_addr_r Zimage; then echo "Loading from FAT is DONE!"; bootz $kernel_addr_r $fdt_addr_r; else echo "Failed to load from FAT"; setenv LOAD_SUCCESS "true"; fi; else echo "mmc device not found"; fi; else echo "Error: Already Loaded from Server"; fi'

run LOAD_FROM_SERVER

run LOAD_FROM_FAT

```

---

## 2) Convert the Script to Binary:
Develop a bash script named bashscript_MakeUbootScriptAsBinary to convert the U-Boot script into a binary format that U-Boot can execute.

### bashscript_MakeUbootScriptAsBinary
```bash
#!/usr/bin/bash

if [ $# -ne 4 ]; then
echo "Please enter your arguments as: $0 <PATH/input_script> <script_load_address> <uboot_entry_point> <PATH/output_file_name>"
exit 1
fi

PATH_for_input_script="$1"
script_load_address="$2"
uboot_entry_point="$3"
PATH_and_output_file_name="$4"

output_dir=$(dirname "$PATH_and_output_file_name")

if [ ! -f "$PATH_for_input_script" ]; then 
echo "Error: Script file '$PATH_for_input_script' not found."
exit 1
fi

if [ ! -d "$output_dir" ]; then 
echo "Error: PATH for output .bin file '$output_dir' doesn't exist"
exit 1
fi

sudo mkimage -A arm -T script -C none -a "$script_load_address" -e "$uboot_entry_point" -n 'MyScript' -d "$PATH_for_input_script" "$PATH_and_output_file_name"

bash
```

---

## 3) Integration with U-Boot:
Configure U-Boot's bootcmd variable to execute the binary version of the script.

```bash
bootcmd= load mmc 0:1 0x60050000 ~/My_Scripts/u-boot_script.bin; source 0x60050000
```

---

## 4) Test with QEMU:
Utilize a script named bashscript_QemuStartUboot to start QEMU with the U-Boot environment and verify that the script is executed successfully.

### bashscript_QemuStartUboot

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
