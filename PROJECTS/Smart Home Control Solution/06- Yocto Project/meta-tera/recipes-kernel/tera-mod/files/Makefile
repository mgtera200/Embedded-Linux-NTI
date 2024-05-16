obj-m += teraGPIO.o
teraGPIO-y := platform_driver.o file_operations.o


all:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) clean