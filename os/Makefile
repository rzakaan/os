#----------------------
# @author Riza Kaan Ucak
# @date 20.01.2022
#----------------------

# Directories
BUILD='build'
BOOT='boot'
KERNEL='kernel'
DRIVERS='drivers'

# Source Files
C_SOURCES = $(wildcard kernel/*.c drivers/*.c )
C_HEADERS = $(wildcard kernel/*.h drivers/*.h )
OBJ_FILES = ${C_SOURCES:.c=.o}

# Compilers and Applications
ASM='nasm'
LD='ld'
CC='gcc'

.PHONY: all build kernel clean

all: run

clean:
	rm ${BUILD}/*.bin -f
	rm ${BUILD}/*.o -f

run: build
	cd ${BUILD} && qemu-system-x86_64 os-image.bin

build: 
	cd ${BOOT} && ${ASM} -f bin boot.asm -o ../${BUILD}/boot.bin
	cd ${BOOT} && ${ASM} -f elf kernel_entry.asm -o ../${BUILD}/kernel_entry.o
	
	cd ${KERNEL} && ${CC} -g -m32 -fno-pie -ffreestanding -c kernel.c -o ../${BUILD}/kernel.o
	cd ${BUILD} && ${LD} -m elf_i386 -Ttext 0x1000 --oformat binary -o kernel kernel.o kernel_entry.o 

	cd ${BUILD} && cat boot.bin kernel > os-image.bin
