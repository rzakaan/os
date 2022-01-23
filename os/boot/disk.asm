; --------------------------------------------
; @author Riza Kaan Ucak
; @date 21.01.2022
; @description Lov Level Disk Services
; --------------------------------------------
;
; --------------------------------------------
; Disk Services
; int 13h
; mov ah, [service code]
;
; CHS (Cylinder Head Sector)
; cylinder > head > track > cluster > sector
; The sector number in CL   ranges from 1 to   63(3F)
; The head number in DH     ranges from 0 to  255(FF), although 255 is seldom used
; The cylinder number in CL ranges from 0 to 1023(3FF). Since this cannot be held in a single byte, 
;     the 2 highest bits of this 10-bit number are stored in bits 6 and 7 of the CL register!
;
; --------------------------------------------
; 0x02 Read Sectors
;
; Args 
; ------
; al    -> number of sectors   (0x01 .. 0x80)
; ch    -> cylinder            (0x00 .. 0x3FF, upper 2 bits in 'cl')
; cl    -> sector              (0x01 .. 0x11)
;          0x01 is our boot sector, 
;          0x02 is the first 'available' sector
; dh    -> head number         (0x00 .. 0xF)
;          side of disk
; dl    -> drive number        (0=floppy, 1=floppy2, 0x80=hdd, 0x81=hdd2)
; es:bx -> buffer
;
; Output
; ------
; cf -> if 0x01 error status else 0x00
; --------------------------------------------


;
; About
;   read data from disk
;
; Args
;   dh    -> number of sectors to read
;
disk_load:
    pusha
    push dx         

    ; first of all, pass the parameters
    mov al, dh          ; number sector
    mov ah, 0x02        ; read sector
    mov cl, 0x02        ; sector
    mov ch, 0x00        ; cylinder
    mov dh, 0x00        ; head number

    int 0x13            ; interrupt disk services
    jc disk_error       ; check error (stored in the carry bit)

    pop dx
    cmp al, dh          ; BIOS sets 'al' to the # of sectors read
    jne sectors_error
    popa
    ret

disk_error:
    ;
    ; ah -> error code
    ; dl -> disk drive
    ;
    mov bx, DISK_ERROR
    call print16
    call print16_nl
    
    mov dh, ah
    call print16_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print16

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error !", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0