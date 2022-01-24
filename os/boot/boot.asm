[org 0x7c00]

KERNEL_OFFSET equ 0x1000 

global _main
_main:
    ; init stack
    mov bp, 0x9000
    mov sp, bp

    mov [BOOT_DRIVE], dl

    call cls16

    mov bx, MSG_INIT
    call print16
    call print16_nl

    call load_kernel
    ;call switch_protected_mode
    jmp $

[bits 16]
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

;[bits 32]
BEGIN_PM:    
    mov ebx, MSG_PM
    call print32
    call KERNEL_OFFSET
    

%include "./print16.asm"
%include "./print32.asm"
%include "./disk.asm"
%include "./gdt.asm"
%include "./switch_protected_mode.asm"

BOOT_DRIVE: db 0
MSG_INIT: db "Started bootloader(16bit)", 0
MSG_LOAD_KERNEL: db "Loading kernel into memory...", 0
MSG_PM: db "Initalized 32bit Protected Mode"

; padding
times 510 - ($-$$) db 0
dw 0xaa55