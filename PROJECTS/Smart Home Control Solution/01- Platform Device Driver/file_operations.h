#ifndef FILE_OPERATION /**< Header guard to prevent multiple inclusion */
#define FILE_OPERATION /**< Define for header inclusion */

#include <linux/init.h> /**< Include header for module initialization */
#include <linux/module.h> /**< Include header for module */
#include <linux/fs.h> /**< Include header for file system operations */
#include <linux/cdev.h> /**< Include header for character device */
#include <linux/uaccess.h> /**< Include header for user space access */
#include <linux/device.h> /**< Include header for device */
#include <linux/platform_device.h> /**< Include header for platform device */
#include <linux/mod_devicetable.h> /**< Include header for module device table */
#include <linux/gpio.h> /**< Include header for GPIO */
#include <linux/string.h> /**< Include header for string manipulation */
#include <linux/of.h> /**< Include header for Open Firmware */
#include <linux/gpio/consumer.h> /**< Include header for GPIO consumer */
#include <linux/property.h> /**< Include header for property */

/*
 * Enum: devices_name
 * -------------------
 * Enumerates the names of devices.
 */
enum devices /**< Enumeration for device names */
{
    led_e, /**< LED device */
    led2_e, /**< LED2 device */
    led3_e, /**< LED3 device */
    buzzer_e, /**< Buzzer device */
    button_e, /**< Button device */
    firesensor_e, /**< Firesensor device */
    smokesensor_e, /**< Smokesensor device */
    switch1_e, /**< Switch1 device */
    switch2_e /**< Switch2 device */
};

/*
 * Enum: devices_pins
 * -------------------
 * Enumerates the pin assignments for devices.
 */
enum devices_pins /**< Enumeration for device pin assignments */
{
    led_2 = 2, /**< Pin assignment for LED */
    led2_3, /**< Pin assignment for LED2 */
    led3_4, /**< Pin assignment for LED3 */
    buzzer_5, /**< Pin assignment for buzzer */
    button_6, /**< Pin assignment for button */
    firesensor_7, /**< Pin assignment for firesensor */
    smokesensor_8, /**< Pin assignment for smokesensor */
    switch1_9, /**< Pin assignment for switch1 */
    switch2_10 /**< Pin assignment for switch2 */
};

/*
 * Function: driver_open
 * ---------------------
 * Called when a device file is opened.
 */
int driver_open(struct inode *device_file, struct file *instance);

/*
 * Function: driver_close
 * ----------------------
 * Called when a device file is closed.
 */
int driver_close(struct inode *device_file, struct file *instance);

/*
 * Function: driver_write
 * ----------------------
 * Called when data is written to a device file.
 */
ssize_t driver_write(struct file *File, const char *user_buffer, size_t count, loff_t *offs);

/*
 * Function: driver_read
 * ---------------------
 * Called when data is read from a device file.
 */
ssize_t driver_read(struct file *File, char *user_buffer, size_t count, loff_t *offs);

#endif // !FILE_OPERATION /**< End of header guard and file inclusion */
