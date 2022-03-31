EXTRN NUMBER: word
EXTRN NEG_FLAG: byte
CSEG SEGMENT para public 'CODE'
	assume CS:CSEG

print_2 proc near

    cmp NEG_FLAG, 1
    jne  gotosplot
    
    mov ah, 2
    mov dl, '-'
    int 21h
    mov ax, NUMBER
    neg ax
    jmp nova

    gotosplot:
    mov ax, NUMBER

    nova:
    mov bx, 2
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
        add dl, '0'
        mov ah, 2
        int 21h
        cmp bp, 0
        jne vivad

    ret

print_2 endp
CSEG ENDS
END