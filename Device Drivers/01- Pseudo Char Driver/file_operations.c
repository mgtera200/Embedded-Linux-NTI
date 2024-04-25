#include "file_operations.h"

#define BUFFER_SIZE 1024 // Define buffer size according to your needs

static char buffer[BUFFER_SIZE]; // Define a static buffer to hold the data
static ssize_t buffer_pointer = 0;

/*
This function is called when the device file is opened
*/
int driver_open(struct inode *device_file, struct file *instance)
{
    printk("dev_nr - open was called!\n");
    return 0;
}

/*
This function is called when the device file is closed
*/

int driver_close(struct inode *device_file, struct file *instance)
{
    printk("dev_nr - close was called!\n");
    return 0;
}

ssize_t driver_write(struct file *File, const char *user_buffer, size_t count, loff_t *offs)
{
    int to_copy, not_copied, delta;

    /* Get amount of data to copy */
    int space_available = BUFFER_SIZE - buffer_pointer;

    /* Get amount of data to copy */
    to_copy = min(count, space_available);

    /* Copy data to buffer */
    not_copied = copy_from_user(buffer + buffer_pointer, user_buffer, to_copy);
    buffer_pointer += to_copy - not_copied;
    /* Calculate data */
    delta = to_copy - not_copied;

    return delta;
}

ssize_t driver_read(struct file *File, char *user_buffer, size_t count, loff_t *offs) {
    int to_copy, not_copied, delta;

    /* Get amount of data to copy */
    to_copy = min(count, buffer_pointer);

    if (to_copy == 0) {
        // No data to read, return EOF
        return 0;
    }

    /* Copy data to user */
    not_copied = copy_to_user(user_buffer, buffer, to_copy);

    /* Adjust buffer pointer */
    buffer_pointer -= to_copy - not_copied;

    /* Calculate data */
    delta = to_copy - not_copied;

    return delta;
}
