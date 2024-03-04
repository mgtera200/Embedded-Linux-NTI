### Description

- Assignment: 
	- Creating Calculator Libraries and Application

- Objective: 
	- You are tasked with creating a static library (liboperation.a) for a simple calculator.
	- The calculator functionalities should be implemented in separate files for addition, subtraction, multiplication, division, and modulus operations.
	
- Files to Create (for each operation):
	- addition.c: Implementation of addition.
	- subtraction.c: Implementation of subtraction.
	- multiplication.c: Implementation of multiplication.
	- division.c: Implementation of division.
	- modulus.c: Implementation of modulus.
- Library Names:
	- Static Library: liboperation.a


### How i solved the assignment 

1- Generate the binary files for Function.c
	- ```gcc -c Codes.c/*.c``` 

2- Generate the library
	- ```ar rcs TeraLib.a addition.o modulus.o multiplication.o subtraction.o division.o```
	
3- Generate the executable file
	- ```gcc src/main.c -I Codes.h/ TeraLib.a```
