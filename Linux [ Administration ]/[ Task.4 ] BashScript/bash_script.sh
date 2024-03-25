#!/usr/bin/bash
echo "Please enter your name:"
read name
echo "Please enter family name:"
read name2
sudo adduser $name
sudo addgroup $name2
sudo usermod -aG $name2 $name
cd /etc/
sudo cat passwd | grep $name
cat group | grep $name2
