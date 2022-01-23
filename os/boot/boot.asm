[org 0x7c00]
[bits 16]

global _start
_start:
    ; init stack
    mov bp, 0x8000
    mov sp, bp

    call cls_16bit
    
    mov bx, MSG_INIT
    call print_16bit
    call print_nl_16bit

    mov bx, AUTHOR
    call print_16bit

    jmp $

_halt:
    hlt

MSG_INIT: db "Initializing custom bootloader", 0
AUTHOR: db "Author Riza Kaan Ucak", 0

%include "./boot_print.asm"

; padding
times 510 - ($-$$) db 0
dw 0xaa55