#include "file_operations.h" /**< Include header file for file operations */

static char led_a[3] = {0}; /**< Static array for LED data */
static char led2_a[3] = {0}; /**< Static array for LED 2 data */
static char led3_a[3] = {0}; /**< Static array for LED 3 data */
static char buzzer_a[3] = {0}; /**< Static array for buzzer data */

int global_minor; /**< Global variable to store minor number */

/*
 * Enum: devices_pins
 * ------------------
 * Enumerates the devices and their associated pins.
 */
enum devices_pins status; /**< Enumeration for device status and pins */

/*
 * Function: driver_open
 * ---------------------
 * Called when the device file is opened.
 *
 * Parameters:
 * - device_file: Pointer to the inode structure representing the device file.
 * - instance: Pointer to the file structure representing the opened file instance.
 *
 * Returns:
 * - 0 on success, otherwise an error code.
 */
int driver_open(struct inode *device_file, struct file *instance)
{
    dev_t dev_id = device_file->i_rdev; /**< Device identifier */
    int major = MAJOR(dev_id); /**< Major number */
    int minor = MINOR(dev_id); /**< Minor number */

    global_minor = minor; /**< Store minor number in global variable */

    instance->private_data = &global_minor; /**< Associate minor number with file instance */

    printk("Opened device with major number %d and minor number %d\n", major, minor); /**< Print message indicating device file is opened */

    return 0; /**< Return success */
}

/*
 * Function: driver_close
 * ----------------------
 * Called when the device file is closed.
 */
int driver_close(struct inode *device_file, struct file *instance)
{
    printk("close FUNCTION was called!\n"); /**< Print message indicating function call */

    return 0; /**< Return success */
}

/*+
 * Function: driver_write
 * ----------------------
 * Called when data is written to a device file.
 *
 * Parameters:
 * - File: Pointer to the file structure representing the device file.
 * - user_buffer: Pointer to the buffer containing the data to be written.
 * - count: Number of bytes to write.
 * - offs: Pointer to the current file position.
 *
 * Returns:
 * - Number of bytes successfully written, or a negative error code on failure.
 */
ssize_t driver_write(struct file *File, const char *user_buffer, size_t count, loff_t *offs)
{
    printk("Write function is entered\n"); /**< Print message indicating function entry */
    char(*value)[3] = NULL; /**< Pointer to value array */
    int not_copied; /**< Variable to store number of bytes not copied */

    if (*(int *)File->private_data == 0)
    {
        printk("The minor who called write is minor 0\n"); /**< Print message for minor 0 */
        value = &led_a; /**< Set value pointer to LED array */
        status = led_2; /**< Set status to LED 2 */
    }
    else if (*(int *)File->private_data == 1)
    {
        printk("The minor who called write is minor 0\n"); /**< Print message for minor 1 */
        value = &led2_a; /**< Set value pointer to LED 2 array */
        status = led2_3; /**< Set status to LED 2 */
    }
    else if (*(int *)File->private_data == 2)
    {
        printk("The minor who called write is minor 0\n"); /**< Print message for minor 2 */
        value = &led3_a; /**< Set value pointer to LED 3 array */
        status = led3_4; /**< Set status to LED 3 */
    }
    else if (*(int *)File->private_data == 3)
    {
        printk("The minor who called write is minor 1\n"); /**< Print message for minor 3 */
        value = &buzzer_a; /**< Set value pointer to buzzer array */
        status = buzzer_5; /**< Set status to buzzer */
    }
    else
    {
        printk("No write permession\n"); /**< Print message for no write permission */
        return -1; /**< Return error code */
    }

    not_copied = copy_from_user(*value, user_buffer, sizeof(led_a)); /**< Copy data from user space to kernel space */

    switch ((*value)[0]) /**< Switch statement based on value */
    {
    case '0':
        gpio_set_value(status, 0); /**< Set GPIO value */
        printk("gpio clear is done\n"); /**< Print message indicating GPIO clear */
        break;
    case '1':
        gpio_set_value(status, 1); /**< Set GPIO value */
        printk("gpio set is done\n"); /**< Print message indicating GPIO set */
        break;
    default:
        printk("gpio Invalid input\n"); /**< Print message for invalid GPIO input */
        break;
    }

    count = count - not_copied; /**< Adjust count based on bytes successfully written */
    return count; /**< Return bytes successfully written */
}

/*
 * Function: driver_read
 * ---------------------
 * Called when data is read from a device file.
 */
ssize_t driver_read(struct file *File, char *user_buffer, size_t count, loff_t *offs)
{
    printk("read function is called\n"); /**< Print message indicating function call */
    int input; /**< Variable to store input */
    char value; /**< Variable to store value */
    int not_copied; /**< Variable to store number of bytes not copied */

    switch (*(int *)File->private_data) /**< Switch statement based on value of private data */
    {
    case 0:
        status = led_2; /**< Set status to LED 2 */
        break;

    case 1:
        status = led2_3; /**< Set status to LED 2 */
        break;

    case 2:
        status = led3_4; /**< Set status to LED 3 */
        break;

    case 3:
        status = buzzer_5; /**< Set status to buzzer */
        break;

    case 4:
        status = button_6; /**< Set status to button */
        break;

    case 5:
        status = firesensor_7; /**< Set status to firesensor */
        break;
    case 6:
        status = smokesensor_8; /**< Set status to smokesensor */
        break;
    case 7:
        status = switch1_9; /**< Set status to switch1 */
        break;

    case 8:
        status = switch2_10; /**< Set status to switch2 */
        break;
    }

    input = gpio_get_value(status); /**< Get GPIO value */
    value = (input == 0) ? '0' : '1'; /**< Set value based on GPIO input */

    if (*offs != 0)
    {
        return 0; /**< Return 0 if offset is not 0 */
    }

    if (copy_to_user(user_buffer, &value, 1) != 0) /**< Copy data from kernel space to user space */
    {
        printk("Failed to copy data to user space\n"); /**< Print message for failed data copy */
        return -EFAULT; /**< Return bad address error */
    }

    printk("Successfully read data: %c\n", value); /**< Print message indicating successful data read */

    *offs += 1; /**< Update offset */

    return 1; /**< Return bytes successfully read */
}
