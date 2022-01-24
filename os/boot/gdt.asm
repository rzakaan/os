gdt_start:
    dd 0x00
    dd 0x00

; code segment descriptor
gdt_code:
    dw 0xffff       ;  0-15 segment length
    dw 0x00         ;  0-15 segment base
    dw 0x00         ; 16-23 segment base
    db 10011010b    ; flags (8 bits)
    db 11001111b    ; 16-19 flags (4 bits) + segment length
    db 0x0          ; 24-31 segment base

; data segment descriptor
gdt_data:
    dw 0xffff       ;  0-15 segment length
    dw 0x00         ;  0-15 segment base
    dw 0x00         ; 16-23 segment base
    db 10011010b    ; flags (8 bits)
    db 11001111b    ; 16-19 flags (4 bits) + segment length
    db 0x0          ; 24-31 segment base

gdt_end:

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; size (16 bit)
    dd gdt_start                ; address (32 bit)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start