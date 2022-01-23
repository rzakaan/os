;
; About
;   clear screen
;
; Args
;   no arguments
;
cls_16bit:
    pusha

    mov ah, 0x00
    mov al, 0x03        ; text mode 80x25 16 colors
    int 0x10

    popa
    ret

;
; About         
;   prints the specified message to the screen
;
; Args
;   bx (ptr)    - it is the base address for the string
;
print_16bit:
    pusha
    mov ah, 0x0e        ; tty(teletype) mode
print_16bit_loop:
    mov al, [bx]        ; *bx -> the value where the pointer points to
    cmp al, 0
    je done
   
    int 0x10

    add bx, 1           ; string[i++] increment pointer and do next loop
    jmp print_16bit_loop
done:
    popa
    ret

;
; About
;   prints new line
;
; Args
;   no args
;
; Notes
;   Dec - Hex  - Oct
;   10  - 0x0A - 12 - Line Feed
;   13  - 0x0D - 13 - Carriage Return
;
print_nl_16bit:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    
    mov al, 0x0d
    int 0x10
    
    popa
    ret