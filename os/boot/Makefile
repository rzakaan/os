all: boot.bin kernel_entry.o
	cp $^ ../build/

%.bin: %.asm
	nasm $< -f bin -o $@

%.o: %.asm
	nasm $< -f elf -o $@

clean:
	rm -rf *.bin *.o