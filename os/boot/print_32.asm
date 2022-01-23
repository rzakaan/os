[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

;
; About         
;   prints the specified message to video memory
;
; Attributes
;   edx - store video mem pointer index
;
; Args
;   bx  - (ptr) it is the base address for the string
;
print32:
    pusha
    mov edx, VIDEO_MEMORY

print32_loop:
    mov ah, WHITE_ON_BLACK
    mov al, [ebx]           ; [ebx] is the address of our character

    cmp al, 0               ; if string[i] == \0 then return
    je print32_done

    mov [edx], ax           ; store character + attribute in video memory
    add ebx, 1              ; string[i++]
    add edx, 2              ; video memory[i++]

    jmp print32_loop

print32_done:
    popa
    ret