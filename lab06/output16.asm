EXTRN NUMBER: word

CSEG SEGMENT para public 'CODE'
	assume CS:CSEG

print_16 proc near

    mov ax, NUMBER
    mov bx, 10h
    xor cx, cx
    xor dx, dx
    mov bp, 0
    revers:
        inc bp
        div bx
        mov si, ax
        mov di, dx
        mov ax, cx
        mul bx
        add ax, di
        mov cx, ax
        mov ax, si
        cmp ax, 0
        jne revers
    
    vivad:
        dec bp
        mov ax, cx
        xor dx, dx
        div bx
        mov cx, ax
        cmp dl, 9
        jbe plus10
        jmp plusA
        outpp:
        mov ah, 2
        int 21h
        cmp bp, 0
        jne vivad
        ret
        plus10:
            add dl, '0'
            jmp outpp
        plusA:
            sub dl, 10
            add dl, 'A'
            jmp outpp

    ret

print_16 endp
CSEG ENDS
END