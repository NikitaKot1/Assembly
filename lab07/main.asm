.model tiny
CODES SEGMENT
    ASSUME CS:CODES, DS:CODES
    ORG 100H
MAIN:
    jmp initialize
    cur db 0
    speed db 1fh ; минимальная скорость
    OLD_8H dd ? ; Адрес старого перывания

MY_NEW_8H proc
    pushf
    call cs:OLD_8H ; Отработка старого прерывания
    
    push ax 
    push dx
    push ds
    push es

    mov ah, 02h ; время
    int 1ah; таймер

    cmp dh, cur ; сравниение времени
    mov cur, dh
    je end_loop
    mov al, 0F3h ; значение ввода
    out 60h, al

    mov al, speed
    out 60h, al

    dec speed

    cmp speed, 0
    jne end_loop
    mov speed, 1fh
    end_loop:
        pop es
        pop ds
        pop dx
        pop ax

    iret

MY_NEW_8H endp

initialize:
    mov AX, 3508h ; предыдущее прерывание
    int 21h

    mov word ptr OLD_8H, BX
    mov word ptr OLD_8H + 2, ES

    mov AX, 2508h ; кастомный вектор прерываний

    mov DX, offset MY_NEW_8H
    int 21h

    mov DX, offset INSTALL_MSG
    mov AH, 9
    int 21h

    mov DX, offset initialize ; смещение по инициализации
    
    int 27H

    INSTALL_MSG   DB 'Install custom breaking$'
CODES ENDS
END MAIN