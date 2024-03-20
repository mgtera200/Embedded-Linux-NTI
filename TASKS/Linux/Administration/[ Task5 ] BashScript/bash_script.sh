#!/bin/bash

# Create backups directory if it doesn't exist
if [ ! -d ~/backups ]; then
    mkdir ~/backups
    echo "[TERA Message] backups directory is created successfully in your Home"
else
    echo "[TERA Message] backups directory exists"
fi

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "[TERA Message] Please provide the paths of your directories"
    exit 1
else
    for directory in "$@"; do
        # Check if the argument is a directory
        if [ -d $directory ]; then
            echo "[TERA Message] $directory exists"
            directory_name=$(basename "$directory")
            tar -cvzf ~/backups/backup_"$directory_name"_$(date +"%Y-%m-%d_%H-%M").tar.gz "$directory"
            if [ -f ~/backups/backup_"$directory_name"_$(date +"%Y-%m-%d_%H-%M").tar.gz ]; then
                echo "[TERA Message] Backup for $directory_name is done successfully"
            else
                echo "[TERA Message] Backup for $directory_name failed"
            fi
        else
            echo "[TERA Message] $directory does not exist or is not a directory"
        fi
    done
fi

