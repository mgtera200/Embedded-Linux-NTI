#include "file_operations.h" /**< Include header file for file operations */

#define DRIVER_NAME "teraDriver" /**< Name of the driver module */
#define DRIVER_CLASS "tera_class" /**< Name of the driver class */
MODULE_LICENSE("GPL"); /**< Specifies the license for the module (GPL - General Public License) */
MODULE_AUTHOR("MOSTAFA TERA"); /**< Specifies the author of the module */
MODULE_DESCRIPTION("Hello from teraaa"); /**< Description of the module */

/** Structure to hold device-related information */
struct mydata
{
    dev_t my_device_nr; /**< Device number */
    struct cdev cdev_object; /**< Represents a character device and provides a way to manage and interact with it */
    struct file_operations fops; /**< File operations structure */
    struct class *my_class; /**< Pointer to the device class */
} teraData_st = {
    .fops = {
        .owner = THIS_MODULE, /**< Owner of the file operations */
        .open = driver_open, /**< Open function for the device */
        .release = driver_close, /**< Close function for the device */
        .read = driver_read, /**< Read function for the device */
        .write = driver_write /**< Write function for the device */
    }};

const struct of_device_id platDeviceIdDTS[10] = {
    {.compatible = "tera,led"}, /**< Device compatible with LED */
    {.compatible = "tera,led2"}, /**< Device compatible with LED2 */
    {.compatible = "tera,led3"}, /**< Device compatible with LED3 */
    {.compatible = "tera,buzzer"}, /**< Device compatible with buzzer */
    {.compatible = "tera,button"}, /**< Device compatible with button */
    {.compatible = "tera,firesensor"}, /**< Device compatible with firesensor */
    {.compatible = "tera,smokesensor"}, /**< Device compatible with smokesensor */
    {.compatible = "tera,switch1"}, /**< Device compatible with switch1 */
    {.compatible = "tera,switch2"}, /**< Device compatible with switch2 */
    {}}; /**< Empty element to terminate the array */

/** Probe function for the platform driver. Called when a device is detected. */
int prob_device(struct platform_device *sLED_P)
{
    struct device *dev = &sLED_P->dev; /**< Pointer to the device structure */
    int ret, buzzer_value, led_value, gpio_pin; /**< Return value and variables for buzzer, LED, and GPIO pin */
    const char *label; /**< Label for the device */

    enum devices node_status; /**< Enumeration for device status */

    if (!device_property_present(dev, "label")) /**< Check if label property is present */
    {
        return -1; /**< Return error code */
    }
    ret = device_property_read_string(dev, "label", &label); /**< Read the label property */
    if (ret) /**< Check if reading label property failed */
    {
        return -1; /**< Return error code */
    }


    if (strcmp(label, "redled") == 0) /**< Check if label is "redled" */
    {
        node_status = led_e; /**< Set node status to LED */
    }
    else if (strcmp(label, "redled2") == 0) /**< Check if label is "redled2" */
    {
        node_status = led2_e; /**< Set node status to LED2 */
    }
    else if (strcmp(label, "redled3") == 0) /**< Check if label is "redled3" */
    {
        node_status = led3_e; /**< Set node status to LED3 */
    }
    else if (strcmp(label, "buzzer") == 0) /**< Check if label is "buzzer" */
    {
        node_status = buzzer_e; /**< Set node status to buzzer */
    }
    else if (strcmp(label, "button") == 0) /**< Check if label is "button" */
    {
        node_status = button_e; /**< Set node status to button */
    }
    else if (strcmp(label, "firesensor") == 0) /**< Check if label is "firesensor" */
    {
        node_status = firesensor_e; /**< Set node status to firesensor */
    }
    else if (strcmp(label, "smokesensor") == 0) /**< Check if label is "smokesensor" */
    {
        node_status = smokesensor_e; /**< Set node status to smokesensor */
    }
    else if (strcmp(label, "switch1") == 0) /**< Check if label is "switch1" */
    {
        node_status = switch1_e; /**< Set node status to switch1 */
    }
    else if (strcmp(label, "switch2") == 0) /**< Check if label is "switch2" */
    {
        node_status = switch2_e; /**< Set node status to switch2 */
    }

    if (node_status == led_e || node_status == led2_e || node_status == led3_e) /**< Check if node status is LED related */
    {
        if (!device_property_present(dev, "led_value")) /**< Check if LED value property is present */
        {
            return -1; /**< Return error code */
        }
        ret = device_property_read_u32(dev, "led_value", &led_value); /**< Read LED value property */
        if (ret) /**< Check if reading LED value property failed */
        {
            return -1; /**< Return error code */
        }
    }

    else if (node_status == buzzer_e) /**< Check if node status is buzzer related */
    {
        if (!device_property_present(dev, "buzzer_value")) /**< Check if buzzer value property is present */
        {
            return -1; /**< Return error code */
        }
        ret = device_property_read_u32(dev, "buzzer_value", &buzzer_value); /**< Read buzzer value property */
        if (ret) /**< Check if reading buzzer value property failed */
        {
            return -1; /**< Return error code */
        }
    }

    if (!device_property_present(dev, "gpio_pin")) /**< Check if GPIO pin property is present */
    {
        return -1; /**< Return error code */
    }

    ret = device_property_read_u32(dev, "gpio_pin", &gpio_pin); /**< Read GPIO pin property */
    if (ret) /**< Check if reading GPIO pin property failed */
    {
        return -1; /**< Return error code */
    }

    if (gpio_request(gpio_pin, "LED_pin")) /**< Check if GPIO pin request is successful */
    {
        printk("Cannot allocate GPIO pin %d\n", gpio_pin); /**< Print error message */
    }
    else
    {
        printk("GPIO pin %d allocated successfully\n", gpio_pin); /**< Print success message */
    }

    if (node_status == led_e || node_status == led2_e || node_status == led3_e) /**< Check if node status is LED related */
    {
        if (gpio_direction_output(gpio_pin, led_value)) /**< Check if setting GPIO pin direction for LED is successful */
        {
            printk("Cannot set the GPIO pin %d to be output\n", gpio_pin); /**< Print error message */
            gpio_free(gpio_pin); /**< Free GPIO pin */
        }
        else
        {
            printk("GPIO pin %d set to be output\n", gpio_pin); /**< Print success message */
        }
    }

    else if (node_status == buzzer_e) /**< Check if node status is buzzer related */
    {

        if (gpio_direction_output(gpio_pin, buzzer_value)) /**< Check if setting GPIO pin direction for buzzer is successful */
        {
            printk("Cannot set the GPIO pin %d to be output\n", gpio_pin); /**< Print error message */
            gpio_free(gpio_pin); /**< Free GPIO pin */
        }
        else
        {
            printk("GPIO pin %d set to be output\n", gpio_pin); /**< Print success message */
        }
    }

    else
    {

        gpio_direction_input(gpio_pin); /**< Set GPIO pin direction to input */
        printk("gpio direction is set to input for label %s\n", label); /**< Print message */
    }

    if (device_create(teraData_st.my_class, NULL, teraData_st.my_device_nr + (node_status), NULL, label) == NULL) /**< Create device file for the detected device */
    {
        printk("Can not create device file for %s!\n", label); /**< Print error message */
    }
    else
    {
        printk("Device file Created for %s!\n", label); /**< Print success message */
    }

    return 0; /**< Return success */
}

/** Function called when removing a platform device */
int device_remove(struct platform_device *sLED_P)
{
    gpio_set_value(2, 0); /**< Set GPIO value */
    gpio_free(2); /**< Free GPIO pin */
    gpio_set_value(3, 0); /**< Set GPIO value */
    gpio_free(3); /**< Free GPIO pin */

    int i = 0; /**< Initialize variable for loop */
    for (i = 0; i < 2; i++) /**< Loop through devices */
    {
        device_destroy(teraData_st.my_class, teraData_st.my_device_nr + i); /**< Destroy device */
    }

    return 0; /**< Return success */
}

/** Structure holding platform driver data */
struct platform_driver platform_driver_data =
    {
        .probe = prob_device, /**< Set probe function */
        .remove = device_remove, /**< Set remove function */
        .driver = {
            .name = "mydriver", /**< Driver name */
            .of_match_table = platDeviceIdDTS}}; /**< Device ID table */

/** Initialization function for the module */
static int __init teraINIT(void)
{
    printk("PLatform driver inserted\n"); /**< Print message */

    if (alloc_chrdev_region(&teraData_st.my_device_nr, 0, 9, DRIVER_NAME) < 0) /**< Allocate character device region */
    {
        printk("Device Nr. could not be allocated!\n"); /**< Print error message */
        return -1; /**< Return error code */
    }

    cdev_init(&teraData_st.cdev_object, &teraData_st.fops); /**< Initialize character device */

    if (cdev_add(&teraData_st.cdev_object, teraData_st.my_device_nr, 9) == -1) /**< Add character device to kernel */
    {
        printk("Adding the device to the kernel failed!\n"); /**< Print error message */
    }

    if (((teraData_st.my_class = class_create(DRIVER_CLASS)) == NULL)) /**< Create device class */
    {
        printk("Device class can not be created!\n"); /**< Print error message */
        goto ClassError; /**< Jump to error handling */
    }

    platform_driver_register(&platform_driver_data); /**< Register platform driver */
    return 0; /**< Return success */

ClassError:
    unregister_chrdev_region(teraData_st.my_device_nr, 9); /**< Unregister character device region */
    return -1; /**< Return error code */
}

/** Deinitialization function for the kernel module */
static void __exit teraDEINIT(void)
{
    platform_driver_unregister(&platform_driver_data); /**< Unregister platform driver */
    class_destroy(teraData_st.my_class); /**< Destroy device class */
    cdev_del(&teraData_st.cdev_object); /**< Delete character device object */
    unregister_chrdev_region(teraData_st.my_device_nr, 9); /**< Unregister character device region */
    printk("Goodbye from tera \n"); /**< Print message */
}

/** Marks the entry point for initializing a kernel module */
module_init(teraINIT);

/** Marks the exit point for cleaning up a kernel module */
module_exit(teraDEINIT);
