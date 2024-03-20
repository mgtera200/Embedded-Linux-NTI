#!/usr/bin/bash

if [ -f ~/.bashrc ]; then
	echo " .bashrc File exists "
	echo "export HELLO=$HOSTNAME" >> ~/.bashrc
	echo "LOCAL=$(whoami)" >> ~/.bashrc
	gnome-terminal
else
	echo " .bashrc file doesnt exist "
fi
