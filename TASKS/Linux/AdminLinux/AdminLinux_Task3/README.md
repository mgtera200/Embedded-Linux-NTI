## Task Description

- **Assignment**: 
	- Creating Bash script

- **Objective**: 
	- Write a Bash script that checks IF the .bashrc file exists in the user's home directory. If it does, append new environment variables to the file: one called HELLO with the value of HOSTNAME, and another local variable called LOCAL with the value of the whoami command.
	- The script should include a command to open another terminal at the end.
	- Describe what happens when the terminal is opened.


## My approach to solve the task

- I wrote my bash script which do the following:
	- Search for .bashrc file and if it exists print **.bashrc File exists**, if it doesnt exist print **.bashrc file doesnt exist**
	- Make global environment variable called HELLO and append its value ```$HOSTNAME``` into .bashrc file
	- Make local environment variable called LOCAL and append its value ```$(whoami)``` into .bashrc file
	- Open terminal using command ```gnome-terminal```

## What happens when the terminal is opened?

- The global variable(HELLO) and the local variable(LOCAL) are created successfully.

