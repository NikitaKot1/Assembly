SD1 SEGMENT para public 'DATA'
    maxl label byte
    actl label byte
    buff db 252 dup ('$')
    nstr db 0Dh, 0Ah, '$'
    inpstr db 'Enter ur str plz:', 0Dh, 0Ah, '$'
    outstr db 'Ur 3d symbol:', 0Dh, 0Ah, '$'
SD1 ENDS

SD2 SEGMENT para public 'DATA'
	SYMB db 'X'
SD2 ENDS

StkSeg SEGMENT PARA STACK 'STACK'
    DB 10h DUP (?)
StkSeg ENDS

CSEG SEGMENT para public 'CODE'
	ASSUME CS:CSEG,  DS:SD1, SS:StkSeg

INPUT_STR:
    mov AH,9;
    mov dx, offset inpstr
    int 21h
    mov ah, 0Ah;ввести
    mov dx, offset maxl
    int 21h
    mov AH,9;перейти на новую строку
    mov dx, offset nstr
    int 21h
    ret

MAIN:
    mov AX, SD1 ; установка сегмента данных с словом
    mov ds, AX
    mov ax, StkSeg ; установка сегмета данных с символом
	mov ss, ax
    call INPUT_STR
assume ES:SD2
    mov ax, SD2 ; установка сегмета данных с символом
	mov ES, ax
    mov si, 3
    mov dh, buff[si]
    mov SYMB, dh

    mov AH,9;ответОчка
    mov dx, offset outstr
    int 21h
    mov AH,2;вывести
    mov dl, SYMB
    int 21h

    mov AH,4Ch ;АН=4Ch завершить процесс
    int 21h 
CSEG ENDS
    END main