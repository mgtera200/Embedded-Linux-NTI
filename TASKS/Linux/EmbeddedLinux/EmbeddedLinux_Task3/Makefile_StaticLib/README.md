# Makefile Description

## Overview
This Makefile is designed to generate a static library and an executable file (.elf) from source files located in user-defined directories. It allows users to specify the source and object directories and provides targets for compiling the source files into object files, creating a static library, and linking the executable. Additionally, it sets a `PATH` variable to include the binary path of the cross-compiler, reducing the need for users to define it every time they open the terminal.

## Features
- **User-Defined Directories**: Users can specify the source and object directories by setting variables within the Makefile.
- **Flexible Compilation**: Supports compilation of source files from custom directories into object files, providing flexibility in project organization.
- **Static Library Generation**: Creates a static library (.a file) from the compiled object files.
- **Executable Generation**: Generates an executable file (.elf) by linking object files with the static library.
- **Cleanup Targets**: Provides cleanup targets to remove generated files and directories.
- **Predefined PATH**: Sets the `PATH` variable to include the binary path of the cross-compiler, simplifying the setup for cross-compilation.

## Structure
- **Variables**: Defines variables for compiler, compiler flags, directories, file names, and `PATH`.
- **Targets**:
  - `all`: Default target to build the static library and the executable.
  - `$(LIB_NAME).a`: Target to create the static library from object files.
  - `$(APP_NAME).elf`: Target to link the executable from object files and the static library.
  - `clean`: Target to remove generated files and directories.
  - `clean_all`: Target to perform a thorough cleanup, removing all generated files and directories.
- **Rules**: Defines rules to compile source files into object files, create the static library, and link the executable.

## Usage
1. **Set Directories**: Optionally, modify the `SRCDIR` and `OBJDIR` variables to specify the source and object directories, respectively.
2. **Build Library and Executable**: Run `make` to compile the source files into object files, generate the static library, and link the executable.
3. **Cleanup**: Run `make clean` to remove generated files and directories.

## My Makefile for a static library
```
CC=arm-cortexa9_neon-linux-musleabihf-
LibFlags=rcs
INCS=-I ./Includes
SRCDIR = Files.c
OBJDIR = Files.o
APPDIR = APP
StaticLibDir = StaticLib
SRC = $(wildcard $(SRCDIR)/*.c)
OBJ = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))
APP_NAME = main
LIB_NAME=TeraLib
ELF_NAME=mainstatic
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/eng-tera/x-tools/arm-cortexa9_neon-linux-musleabihf/bin

all: $(ELF_NAME).elf
	@echo "Build is done successfully [ Eng.TERA ]"
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(dir $@)
	$(CC)cc -c $(INCS) $< -o $@
	
StaticLib/$(LIB_NAME).a: $(OBJ)
	mkdir $(StaticLibDir)
	$(CC)ar $(LibFlags) $@ $(OBJ)
$(ELF_NAME).elf: $(StaticLibDir)/$(LIB_NAME).a
	$(CC)gcc $(APPDIR)/$(APP_NAME).c $(INCS) $(StaticLibDir)/$(LIB_NAME).a -o $@

clean:
	rm *.elf 
	rm -r $(StaticLibDir) $(OBJDIR)
	@echo "Directory is cleaned successfully [ Eng.TERA ]"

