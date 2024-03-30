# Setting Up Custom Services in systemd on Ubuntu

## Introduction
This guide outlines the steps to create and manage custom services using systemd on Ubuntu. We'll create a simple service called "Test Service" that runs a bash script continuously, along with instructions for installing and managing the SSH server (`sshd`) and Apache HTTP Server (`apache2.service`).

## Step 1: Install SSH Server (`sshd`) and Apache HTTP Server (`apache2`)
Before setting up our custom service, let's install the SSH server and Apache HTTP Server to enable remote access and serve web content.

Install SSH server:
```bash
sudo apt update
sudo apt install openssh-server
```
Install Apache HTTP Server:

```bash
sudo apt install apache2
```
## Step 2: Create the Service Script

First, let's create the script that our service will run.

```bash
cd ~
vim daemonapp-service.sh
```
```bash
#!/bin/bash
# This script runs continuously, logging the current date every 10 seconds
while true
do
	date >> /tmp/daemonapp-service.out
	sleep 10
done
```
After creating the script, make it executable and label it appropriately:

```bash
sudo chmod a+x daemonapp-service.sh
chcon -t bin_t daemonapp-service.sh
```

## Step 3: Define the systemd Service Unit File

Now, let's create the systemd unit file for our service.

```bash
cd /etc/systemd/system
```
```bash
vim test-service.service
```

```bash
[Unit]
Description=Test Service
After=network.target sshd.service
Wants=apache2.service

[Service]
Type=simple
ExecStart=/home/eng-tera/daemonapp-service.sh
Restart=always
RestartSec=10s

[Install] 
WantedBy=multi-user.target
```

In this file:

`Description`: Provides a brief description of the service.
`After`: Specifies the units that must be started before this service.
`Wants`: Declares that this service wants the Apache HTTP Server (apache2.service) to be started.
`ExecStart`: Specifies the command to start the service.
`Restart`: Sets the restart behavior to always.
`RestartSec`: Defines the time to wait before restarting the service.

## Step 4: Reload systemd and Enable the Service

After creating the unit file, reload systemd to read the new configuration and enable our service.

```bash
systemctl daemon-reload
```
```bash
systemctl enable --now test-service.service
```
## Step 5: Manage the Service

Now, let's manage our service.

Check the status of a specific service:

```bash
systemctl status apache2.service
```

Stop the service:

```bash
systemctl stop apache2.service
```

Check the status of our service:

```bash
systemctl status test-service.service
```
Check the status of Apache HTTP Server (apache2.service):

```bash
systemctl status apache2.service
```
Notice that test-service.service is still running as it wants apache2.service but doesn't NEED it.

## Step 6: Verify Functionality


Check Initial Service Status:

```bash
systemctl start test-service.service
```
Check if the daemonapp-service.sh is up:

```bash
ps -ef | grep daemonapp-service.sh
```
Check for daemonapp functionality:

```bash
tail -f /tmp/daemonapp-service.out
```


Add Restart Option:
We'll add a restart option to ensure the service restarts automatically if something goes wrong. Use the following command to edit the service unit file:

```bash
sudo systemctl edit test-service.service
```
Add the following lines to the override file:

```bash
[Service]
Restart=always
RestartSec=10s
```
After saving the changes, systemd will automatically read the override.

Test Service Restart:
Now, let's simulate a failure by killing the daemonapp-service.sh process and observe the service's behavior:

```bash
ps -ef | grep daemonapp-service.sh
```
```bash
sudo kill <process_id>
```
```bash
systemctl status test-service.service
```
After a few seconds (as defined by RestartSec), the service should restart automatically.

By following these steps, you've ensured that your service restarts automatically in case of failure, providing better reliability and uptime.

## Conclusion
By following these steps, you've successfully created and managed a custom systemd service on Ubuntu. You've also learned about service dependencies, restart options, and system overrides.
