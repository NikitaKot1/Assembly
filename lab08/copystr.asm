global copy
section .text

copy:
	mov rcx, rdx
	cmp rsi, rdi ; Если равны выходим.
	je end
	lea rax, [rsi]
	add rax, rdx ; Теперь rax указывает на конец строки.
	cmp rax, rdi 
	jg backward; Eсли больше  
	CLD ; Двигаемся вперед по строкам 

	rep movsb 
	jmp end

backward:
	add rsi, rdx
	add rdi, rdx
	dec rsi 
	dec rdi 
	std ; Двигаемся назад по строкам (DF = 1)
	rep movsb

end:
ret