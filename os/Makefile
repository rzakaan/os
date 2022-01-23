#----------------------
# @author Riza Kaan Ucak
# @date 20.01.2022
#----------------------

# Directories
BUILD='build'
BOOT='boot'
KERNEL='kernel'
DRIVERS='drivers'

# Compilers and Applications
ASM='nasm'
.PHONY: all build clean

all: run

clean:
	rm ${BUILD}/*.bin -f
	rm ${BUILD}/*.o -f

run: build
	cd ${BUILD} && qemu-system-x86_64 boot.bin
	
build: 
	cd ${BOOT} && ${ASM} -f bin boot.asm -o ../${BUILD}/boot.bin
