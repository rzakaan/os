[bits 32]

global _start
_start:
    [extern start_kernel]   ; must have same name as kernel.c 'main' function
    call start_kernel       ; calls the C function. The linker will know where it is placed in memory
    jmp $