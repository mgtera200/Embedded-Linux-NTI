#include "file_operations.h"

#define DRIVER_NAME "teraDriver"
#define DRIVER_CLASS "tera_class"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("MOSTAFA TERA");
MODULE_DESCRIPTION("Hello from teraaa");

struct mydata
{
    dev_t my_device_nr;
    struct cdev cdev_object;// Represents a character device 
                            // and provides a way to manage and interact with it
    struct file_operations fops;
    struct class *my_class;
} teraData_st = {
    .fops = {
        .owner = THIS_MODULE,
        .open = driver_open,
        .release = driver_close,
        .read = driver_read,
        .write = driver_write}};

static int __init teraINIT(void)
{
    printk("HELLO from tera\n");

/**
 * ========== alloc_chrdev_region() =============
 * Allocates a range of character device numbers dynamically.
 * 
 * @param dev: Pointer to a variable to hold the allocated device number(s).
 * @param baseminor: The base of the range of minor numbers.
 * @param count: The number of contiguous device numbers to allocate.
 * @param name: Name of the driver for identification purposes.
 * @return 0 on success, a negative error code on failure.
 */
    if (alloc_chrdev_region(&teraData_st.my_device_nr, 0, 1, DRIVER_NAME) < 0)
    {
        printk("Device Nr. could not be allocated!\n");
        return -1;
    }
    printk("%s retval=0 - registered Device number Major: %d, Minor: %d\n", __FUNCTION__, MAJOR(teraData_st.my_device_nr), MINOR(teraData_st.my_device_nr));


/**
 * =========== cdev_init() ===============
 * Initializes a struct cdev structure representing a character device.
 *
 * @param cdev: Pointer to the struct cdev structure to initialize.
 * @param fops: Pointer to the file operations structure defining device behavior.
 */
    cdev_init(&teraData_st.cdev_object, &teraData_st.fops);


/**
 * ============ cdev_add ==============
 * Registers a character device with the kernel.
 *
 * @param p: Pointer to the struct cdev structure representing the character device.
 * @param dev: Device number allocated by alloc_chrdev_region.
 * @param count: Number of minor numbers corresponding to this device.
 * @return 0 on success, a negative error code on failure.
 */
    if (cdev_add(&teraData_st.cdev_object, teraData_st.my_device_nr, 1) == -1)
    {
        printk("Adding the device to the kernel failed!\n");
        goto DEV_ERROR;
    }

/**
 * ============ class_create =============
 * Creates a device class in sysfs.
 *
 * @param owner: Owner module of the class.
 * @param name: Name of the class.
 * @return Pointer to the created class on success, NULL on failure.
 */
    if (((teraData_st.my_class = class_create(DRIVER_CLASS)) == NULL))
    {
        printk("Device class can not be created!\n");
        goto ClassError;
    }

/**
 * ============ device_create ============
 * Creates a device and registers it with sysfs.
 *
 * @param class: Pointer to the class the device is associated with.
 * @param parent: Pointer to the parent device, or NULL.
 * @param devt: Device number to associate with the device.
 * @param drvdata: Pointer to driver-specific data to associate with the device.
 * @param fmt: Format string for the device name.
 * @param ...: Arguments to be formatted according to fmt.
 * @return Pointer to the created device on success, NULL on failure.
 */

    if (device_create(teraData_st.my_class, NULL, teraData_st.my_device_nr, NULL, DRIVER_NAME) == NULL)
    {
        printk("Can not create device file!\n");
        goto FileError;
    }
    return 0;
FileError:
    class_destroy(teraData_st.my_class);
ClassError:
    cdev_del(&teraData_st.cdev_object);
DEV_ERROR:
    unregister_chrdev_region(teraData_st.my_device_nr, 1);
    return -1;
}

static void __exit teraDEINIT(void)
{
    device_destroy(teraData_st.my_class,teraData_st.my_device_nr);
    class_destroy(teraData_st.my_class);
    cdev_del(&teraData_st.cdev_object);
    unregister_chrdev_region(teraData_st.my_device_nr, 1);
    printk("Goodbye from tera \n");
}
/* Macro: module_init
 * ------------------
 * This macro marks the entry point for initializing a kernel module. It specifies
 * the function that should be called when the module is loaded into the kernel.
 * The specified function is automatically invoked by the kernel upon module insertion.
 */
module_init(teraINIT);

/* Macro: module_exit
 * -------------------
 * This macro marks the exit point for cleaning up a kernel module. It specifies
 * the function that should be called when the module is removed from the kernel.
 * The specified function is automatically invoked by the kernel upon module removal.
 */
module_exit(teraDEINIT);