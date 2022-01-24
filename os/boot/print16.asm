;
; About
;   clear screen
;
; Args
;   no arguments
;
cls16:
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
;   bx  - (ptr) it is the base address for the string
;
print16:
    pusha
    mov ah, 0x0e        ; tty(teletype) mode
print16_loop:
    mov al, [bx]        ; *bx -> the value where the pointer points to
    cmp al, 0
    je done
   
    int 0x10

    add bx, 1           ; string[i++] increment pointer and do next loop
    jmp print16_loop
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
;   Dec - Hex
;   10  - 0x0A - Line Feed
;   13  - 0x0D - Carriage Return
;
print16_nl:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    
    mov al, 0x0d
    int 0x10
    
    popa
    ret

;
; About
;   prints value to the screen in hex format
;
; Attr
;   ax  - working register
;   bx  - usage for call print value
;   cx  - usage for looping index
;
; Args
;   dx  - (ptr) data to be printed to the screen
;
; Notes
;   Dec - Hex  - 
;   48  - 0x30 - '0'
;   57  - 0x39 - '9'
;   65  - 0x41 - 'A'
;   70  - 0x46 - '9'
print16_hex:
    pusha
    push cx
    mov cx, 0
print16_hex_loop:
    cmp cx, 4           ; cx usage for looping
    je print16_hex_end

    ; convert last char in dx to ascii
    mov ax, dx
    and ax, 0x000f      ; mask
    add al, 0x30        ; '0'
    cmp al, 0x39        ; if > 9 then represent 'A' to 'F'
    jle print16_hex_loop2
    add al, 7           ; 'A' is ASCII 65 instead of 58, so 65-58=7

print16_hex_loop2:
    mov bx, HEX16 + 5
    sub bx, cx
    mov [bx], al
    ror dx, 4           ; rotate right -> 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    add cx, 1
    jmp print16_hex_loop

print16_hex_end:
    mov bx, HEX16
    call print16
    popa
    ret

HEX16: db '0x0000',0