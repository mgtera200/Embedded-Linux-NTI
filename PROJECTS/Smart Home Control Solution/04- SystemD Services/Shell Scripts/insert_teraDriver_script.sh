#!/bin/bash
sudo insmod /home/pi/device_driver/gpio_driver.ko
sudo chmod 777 /dev/redled
sudo chmod 777 /dev/redled2
sudo chmod 777 /dev/redled2
sudo chmod 777 /dev/buzzer
sudo chmod 777 /dev/button
sudo chmod 777 /dev/firesensor
sudo chmod 777 /dev/smokesensor
sudo chmod 777 /dev/switch1
sudo chmod 777 /dev/switch2

sudo pip install pigpio-dht --break-system-package
echo "insmod is running"
