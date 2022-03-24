MATR SEGMENT para public 'DATA'
    n db 1
    m db 1
    imax dw 1
    imin dw 1
    arr db 81 dup (0)
    msg_ent db 13, 10, '$'
    msg_err_big_num db 13, 10, 'This is not a number!', 13, 10, '$'
    msg_err_zero_num db 13, 10, '0 cant be a size of matrix!', 13, 10, '$'
    msg_inp_n db 'Input N: $'
    msg_inp_m db 'Input M: $'
    msg_inp_matr db 'Input matrix:', 13, 10, '$'
    msg_inp_new db 13, 10, 13, 10, 'New matrix:', '$'
    zn dw 1
    max label byte
    min label byte
MATR ENDS

StkSeg SEGMENT PARA STACK 'STACK'
    DB 100h DUP (?)
StkSeg ENDS

CSEG SEGMENT para public 'CODE'
	ASSUME CS:CSEG,  DS:MATR, SS:StkSeg

input_number:
    mov ah, 01h         ; получение символа
    int 21h             ; он теперь в al

    cmp al, 0dh         ; если вдруг уже Enter
    je input_number     ; улетаем в начало
    cmp al, ' '         ; если пробел
    je input_number     ; улетаем в начало

    cmp al, '0'         ; если < 0
    jb err_big_num
    cmp al, '9'         ; если > 9
    ja err_big_num
    sub al, 30h         ; теперь это цифра
    ret

new_line:
    mov AH,9
    mov dx, offset msg_ent
    int 21h
    ret

max_swap:
    cmp max, bh
    jb swap_max
    ret
    swap_max:
        mov max, bh
        mov ax, si
        mov bl, n
        div bl
        mov ah, 0
        mov imax, ax
        ret

min_swap:
    cmp min, bh
    ja swap_min
    ret
    swap_min:
        mov min, bh
        mov ax, si
        mov bl, n
        div bl
        mov ah, 0
        mov imin, ax
        ret

print_matrix:
    call new_line
    mov al, m
    mov cl, n           ; перемножить
    mul cl              ; перемножить
    mov cx, ax
    mov AH, 2           ; вывести
    mov si, 0
    mov bl, 0
    print_loop:
        mov al, arr[si]
        add al, '0'
        mov AH, 2 
        mov dl, al
        int 21h
        mov dl, ' '
        int 21h
        inc si
        inc bl
        cmp bl, m
        je ent_line
        entloop:
        loop print_loop
    ret
    ent_line:
        call new_line
        mov bl, 0
        jmp entloop
    ret
main:
    mov AX, MATR        ; установка сегмента данных
    mov ds, AX
    mov AH,9
    mov dx, offset msg_inp_n
    int 21h
    call input_number
    cmp al, 0
    je err_zer_num
    mov n, al

    call new_line
    mov AH,9
    mov dx, offset msg_inp_m
    int 21h
    call input_number
    cmp al, 0
    je err_zer_num
    mov m, al

    call new_line

    mov cl, n           ; перемножить
    mul cl              ; перемножить
    mov zn, ax          ; положить отдельно
    mov si, 0
    inc zn
    mov AH,9
    mov dx, offset msg_inp_matr
    int 21h
    inp_loop:
        call input_number
        mov arr[si], al
        inc si
        dec zn
        mov cx, zn
        loop inp_loop

    mov al, m
    mov cl, n           ; перемножить
    mul cl              ; перемножить
    mov cx, ax
    dec cx

    mov si, 0
    mov imax, 0
    mov imin, 0
    mov bh, arr[si]
    mov max, bh
    mov min, bh

    find_loop:
        inc si
        mov bh, arr[si]
        call max_swap
        call min_swap
        loop find_loop

    mov cl, n
    mov ch, 0
    
    mov bl, 0
    mov si, imax
    mov di, imin
    change_loop:
        mov al, arr[si]
        mov bl, arr[di]
        mov arr[si], bl
        mov arr[di], al

        mov al, m
        mov ah, 0
        add si, ax
        add di, ax

        loop change_loop

    mov AH,9
    mov dx, offset msg_inp_new
    int 21h
    call print_matrix

    jmp end_prog

    end_prog:
        mov AH,4Ch      ; завершить процесс
        int 21h 

    err_big_num:
        mov AH,9;
        mov dx, offset msg_err_big_num
        int 21h
        jmp end_prog

    err_zer_num:
        mov AH,9;
        mov dx, offset msg_err_zero_num
        int 21h
        jmp end_prog
        
CSEG ENDS
    END main