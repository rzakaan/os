BUILD=../build
all: boot.bin kernel_entry.o
	mkdir -p ${BUILD}
	cp $^ ${BUILD}

%.bin: %.asm
	nasm $< -f bin -o $@

%.o: %.asm
	nasm $< -f elf -o $@

clean:
	rm -rf *.bin *.o