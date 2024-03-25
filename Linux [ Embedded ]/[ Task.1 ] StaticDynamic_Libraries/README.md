# Task Description

### Assignment: 
- Creating Calculator Libraries and Application

### Objective: 
- You are tasked with creating both a static library (liboperation.a) and a shared library for a simple calculator.
- The calculator functionalities should be implemented in separate files for addition, subtraction, multiplication, division, and modulus operations.
	
### Files to Create (for each operation):
- addition.c: Implementation of addition.
- subtraction.c: Implementation of subtraction.
- multiplication.c: Implementation of multiplication.
- division.c: Implementation of division.
- modulus.c: Implementation of modulus.
### Library Names:
- Static Library: liboperation.a
- Shared Library: liboperation.so

---

# 1- Static Library

1- **Generate the binary files for Function.c**

	  gcc -c Functions.c/*.c

2- **Generate the library**

	  ar rcs TeraLib.a ./Files.o/*.o
	
3- **Generate the executable file**

	  gcc ./app/main.c -L. ./Library_Static/TeraLib.a -o mainstatic.elf
	  

## IMPORTANT NOTES:

 ```ldd mainstatic.elf``` will result in:

> 
```
 linux-vdso.so.1 (0x00007ffcdabcf000)
 libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fde52000000)
 /lib64/ld-linux-x86-64.so.2 (0x00007fde5240c000)
```

So this means that my mainstatic.elf file is still **dynamically linked**, to make it full statically linked we use ```gcc -static ./app/main.c -L. ./Library/TeraLib.a ```

Now ```ldd mainstatic.elf``` will result in ```not a dynamic executable``` and the file size will be **much bigger** than before.

Also if we use file command ```file mainstatic.elf```

You see that it is statically linked:
```
mainstatic.elf: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, BuildID[sha1]=f4cb1e54769ac57cee717fd927c400c4f47b1df3, for GNU/Linux 3.2.0, not stripped
```
---

# 2- Dynamic Library

1- **Generate the binary files for Function.c**

	  gcc -c -Wall -fPIC ./Functions.c/*.c

2- **Generate the library**	

	  gcc -shared *.o -o libTERA.so

3- **Generate the executable file**

	  gcc ./app/main.c -L./Library_Dynamic -lTERA -o maindyn.elf


## IMPORTANT NOTES:

When using file command ```file maindyn.elf``` 

You see that it is dynamically linked:

```
maindyn.elf: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=6748461526784446e3a3787f2470ea02e6442e69, for GNU Linux 3.2.0, not stripped
```

When using ldd command ```ldd maindyn.elf```

You see that the library address **not found:**
 
```linux-vdso.so.1 (0x00007fff30f8f000)
libTERA.so => not found
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f0035400000)
/lib64/ld-linux-x86-64.so.2 (0x00007f0035838000)
```

## TO SOLVE [ libTERA.so => not found ] PROBLEM WE HAVE 3 METHODS:


## METHOD #1

Copy the library to /usr/lib ```sudo cp libTERA.so /usr/lib```
 
So when you use ldd command ```ldd maindyn.elf```
 
You find that the proplem got solved
       
```
linux-vdso.so.1 (0x00007fff6a3ba000)
libTERA.so => /lib/libTERA.so (0x00007f7efbf2b000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7efbc00000)
/lib64/ld-linux-x86-64.so.2 (0x00007f7efbf48000)
```

---

## METHOD #2

Make environment variable and initialize its value with the library path ```export LD_LIBRARY_PATH=~/Documents/Dynamic_Library/```

Now when you use ldd command ```ldd maindyn.elf``` 

You find that the proplem got solved

```
linux-vdso.so.1 (0x00007ffee67f8000)
libTERA.so => /home/eng-tera/Documents/Dynamic_Library/libTERA.so (0x00007ff69f31e000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007ff69f000000)
/lib64/ld-linux-x86-64.so.2 (0x00007ff69f32a000)
```
       
---
       
## METHOD #3

We use put the library path during compilation ```gcc ./app/main.c -L./Library/ -Wl,-rpath=./Library/ -Wall -lTERA -o maindyn.elf```

Now when we use ldd command ```ldd maindyn.elf``` 
			       

```		       
linux-vdso.so.1 (0x00007ffe6e30d000)
libTERA.so => ./Library/libTERA.so (0x00007f83f5a37000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f83f5600000)
/lib64/ld-linux-x86-64.so.2 (0x00007f83f5a43000)```
```

---

### NOTE THAT : THE DYNAMIC LINKER PRIORITY FOR THESE METHODS IS #2, #3, #1

---

# 3- Static VS Dynamic

| Feature             | Static Library                           | Shared Library                           |
|---------------------|------------------------------------------|------------------------------------------|
| File Extension      | `.a` (Archive)                           | `.so` (Shared Object)                   |
| Compilation         | Compiled into the final executable      | Compiled separately and linked at runtime |
| Size                | Larger                                    | Smaller                                  |
| Memory Usage        | Entire library is loaded into memory     | Portions of the library are loaded on demand |
| Linking Time        | Longer                                   | Shorter                                  |
| Dependency          | Embeds library code into the executable | Requires the library to be present at runtime |
| Portability         | Less portable (platform dependent)       | More portable (can be shared among different applications) |
| Reusability         | Less reusable (specific to the application) | More reusable (can be shared among multiple applications) |
| Versioning          | No versioning support                    | Supports versioning                      |
| Updates             | Requires recompilation for updates       | Can be updated independently of applications |
| Security            | Generally more secure (no runtime dependencies) | Potential security concerns (shared code execution) |
| Debugging           | Easier to debug (source code included)  | Harder to debug (need debug symbols and original library) |


