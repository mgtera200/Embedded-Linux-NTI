# Task Description

## Assignment: 

- Your task is to create a bash script for automated backups.
- Write a script that takes a list of directories as arguments and creates a compressed backup (tarball) of each specified directory.
- The script should include the current date in the backup filename and store the backups in a designated backup directory.

---

## Objective: 
- The script should accept one or more directory paths as command-line arguments.
- For each specified directory, create a compressed backup file in the format backup_<directory>_<date>.tar.gz.
- Place all backup files in a backup directory named backups within the script's working directory.
- Ensure that the script creates the backups directory if it does not exist.
- Display appropriate messages indicating the success or failure of each backup.

---

# My Bash Script

```
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
```

---

# Script Features

- Checks if no arguments are given.
- Check if the backup directory doesn't exist and creates one.
- Check that the path given as argument is valid and that the directory exists.
- Check whether the backup operation for each directory is completed successfully or failed.

