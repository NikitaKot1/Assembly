PUBLIC uppend_num
PUBLIC NUMBER
PUBLIC NEG_FLAG
MENU SEGMENT para public 'DATA'
    NUMBER dw 0
    NEG_FLAG db 0
MENU ends

CSEG SEGMENT para public 'CODE'
	assume CS:CSEG,  DS:MENU

uppend_num proc near
    mov ah, 01h         ; получение символа
    int 21h             ; он теперь в al
    mov NEG_FLAG, 0
    xor bx, bx
    xor dx, dx
    mov cl, 8
    cmp al, '-'         ;
    je somomso
    jmp nstart

    start_csl:
        mov ah, 01h         ; получение символа
        int 21h             ; он теперь в al
        nstart:
        cmp al, 0dh         ; если вдруг уже Enter
        je ennnn            ; улетаем в конец
        sub al, '0'         ; теперь это цифра
        mov bl, al
        xor bh, bh
        mov ax, dx
        mul cl
        add ax, bx
        mov dx, ax
        jmp start_csl

    somomso:
        mov ch, 1
        xor al, al
        jmp start_csl

    ennnn:
        cmp ch, 1
        je negg
        outp:
        mov NUMBER, dx
        ret
    negg:
        neg dx
        mov NEG_FLAG, 1
        jmp outp
uppend_num endp
CSEG ENDS
END