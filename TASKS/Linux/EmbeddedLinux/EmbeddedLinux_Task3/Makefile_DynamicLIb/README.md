# Dynamic Library Makefile Description

This Makefile is designed to generate a dynamic library for ARM Cortex-A9 architecture using a cross toolchain (`arm-cortexa9_neon-linux-musleabihf-`). Below is a detailed explanation of each section and functionality provided by the Makefile:

## Variables:

- **CC**: Compiler command used for compiling C code.
- **LibFlags**: Flags passed to the compiler for generating the dynamic library (`-Wall -fPIC`).
- **INCS**: Include directories for header files.
- **SRCDIR**: Directory containing source files (`Files.c`).
- **OBJDIR**: Directory for storing object files.
- **APPDIR**: Directory containing the application code.
- **DynamicLibDir**: Directory for storing the generated dynamic library.
- **SRC**: List of source files.
- **OBJ**: List of object files generated from source files.
- **APP_NAME**: Name of the application.
- **LIB_NAME**: Name of the dynamic library.
- **ELF_NAME**: Name of the executable file.

## Targets:

- **all**: Default target that generates the ELF executable file (`$(ELF_NAME).elf`) after building the dynamic library.
- **%.o**: Rule for generating object files from C source files.
- **$(DynamicLibDir)/$(LIB_NAME).so**: Target for generating the dynamic library.
- **$(ELF_NAME).elf**: Target for generating the ELF executable file using the dynamic library.

## Rules:

1. **%.o**: Compiles each source file in `$(SRCDIR)` to its corresponding object file in `$(OBJDIR)`.
2. **$(DynamicLibDir)/$(LIB_NAME).so**: Generates the dynamic library by compiling all object files.
3. **$(ELF_NAME).elf**: Links the application code with the dynamic library to generate the ELF executable file.

## Clean:

- **clean**: Removes all generated ELF files, dynamic library, and object files, and cleans up directories.

