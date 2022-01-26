#----------------------
# @author Riza Kaan Ucak
# @date 25.01.2022
#----------------------

.PHONY: clean

C_SOURCES = $(wildcard kernel/*.c drivers/*.c libc/*.c)
C_HEADERS = $(wildcard kernel/*.h drivers/*.h libc/*.h)
C_OBJECTS = ${C_SOURCES:.c=.o}

# Directories
BUILD=build

# check OS
UNAME  := $(shell uname -s)
UNAME_P:= $(shell uname -p)
ifeq ($(UNAME), Linux)
	ASM='nasm'
	GDB=gdb
	CC=gcc
	CFLAGS=-c -m32 -ffreestanding -fno-pie -g
	LD='ld'
	LDFLAGS=-m elf_i386 -Ttext 0x1000 --oformat binary
	VM=qemu-system-i386
endif
ifeq ($(UNAME), Darwin)
    # MacOs
	ASM='nasm'
	GDB=/usr/local/i386elfgcc/bin/i386-elf-gdb
	CC=/usr/local/i386elfgcc/bin/i386-elf-gcc
	CFLAGS=-c -m32 -ffreestanding -g
	Ld=i386-elf-ld
	VM=qemu-system-i386
endif

OS_IMAGE=os-image.bin

all: bootloader ${OS_IMAGE}

bootloader: 
	$(MAKE) -C boot/

${OS_IMAGE}: kernel.bin
	cat build/boot.bin $^ > ${OS_IMAGE}

kernel.bin: ${BUILD}/kernel_entry.o ${C_OBJECTS}
	${LD} ${LDFLAGS} $^ -o $@

# used for debugging purposes
kernel.elf: ${C_OBJECTS}
	${LD} ${LDFLAGS} build/kernel_entry.o $^ -o $@

# compile c files : kernel, drivers
%.o: %.c ${C_HEADERS}
	${CC} ${CFLAGS} $< -o $@

clean:
	rm -f ${BUILD}/*.bin ${BUILD}/*.o ${BUILD}/${OS_IMAGE}
	rm -f *.bin *.o ${OS_IMAGE} 
	rm -f boot/*.bin boot/*.o kernel/*.o drivers/*.o libc/*.o

debug: ${OS_IMAGE} kernel.elf
	${VM} -s -fda os-image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

run: ${OS_IMAGE}
	${VM} -fda ${OS_IMAGE}