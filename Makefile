# Specify flags for the module compilation.
#EXTRA_CFLAGS=-g -O0

# If KERNELRELEASE is defined， we've been invoked from the
# kernel build system and can use its language.
ifneq ($(KERNELRELEASE),)
carl9170-objs := main.o usb.o cmd.o mac.o phy.o led.o fw.o tx.o rx.o
carl9170-$(CONFIG_CARL9170_DEBUGFS) += debug.o

obj-m += carl9170.o
# Otherwise we were called directly from the command
# line; invoke the kernel build system.
else
KERNELDIR ?=/lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
clean:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
endif
