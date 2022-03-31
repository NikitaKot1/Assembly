EXTRN uppend_num: near
EXTRN print_16: near
EXTRN print_2: near
EXTRN NUMBER: word
MENU SEGMENT para public 'DATA'
    menu_msg db 13, 10, 'Lab 6:', 13, 10
        db 'Input a sighed octal number           -- 1', 13, 10
        db 'Output an unsigned hexadecimal number -- 2', 13, 10
        db 'Output a signed binary number         -- 3', 13, 10
        db 'Exit                                  -- 0', 13, 10, '$'
    msg_new   db 13, 10, '$'
    arr_of_func dw exit, uppend_num, print_16, print_2
MENU ends


StkSeg SEGMENT PARA STACK 'STACK'
    DB 100h DUP (?)
StkSeg ENDS

CSEG SEGMENT para public 'CODE'
	ASSUME CS:CSEG,  DS:MENU, SS:StkSeg

exit:
    mov AH,4Ch      ; завершить процесс
    int 21h  

main:
    mov ax, MENU
    mov ds, ax

    infinit:
        mov AH,9;
        mov dx, offset msg_new
        int 21h
        mov dx, offset menu_msg
        int 21h
        mov ah, 1
        int 21h
        sub al, '0'
        mov AH,9;
        mov dx, offset msg_new
        int 21h
        xor ah, ah
        mov cl, 2
        mul cl
        mov si, ax
        call arr_of_func[si]
        jmp infinit
CSEG ENDS
    END main