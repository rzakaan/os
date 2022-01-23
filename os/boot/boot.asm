[org 0x7c00]
[bits 16]

KERNEL_OFFSET equ 0x1000 

global _main
_main:
    ; init stack
    mov bp, 0x9000
    mov sp, bp

    mov [BOOT_DRIVE], dl

    call cls16

    mov bx, AUTHOR
    call print16
    call print16_nl

    mov bx, MSG_INIT
    call print16
    call print16_nl

    call load_kernel
    jmp $

_halt:
    hlt

load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print16
    call print16_nl

    ; Read from disk and store in 0x1000
    mov bx, KERNEL_OFFSET   ; bx -> destination
    mov dh, 31              ; dh -> num sectors
    mov dl, [BOOT_DRIVE]    ; dl -> disk
    call disk_load
    ret


%include "./print_16.asm"
%include "./disk.asm"

BOOT_DRIVE: db 0
AUTHOR: db "Author Riza Kaan Ucak", 0
MSG_INIT: db "Started bootloader in real mode(16bit)", 0
MSG_LOAD_KERNEL: db "Loading kernel ...", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55