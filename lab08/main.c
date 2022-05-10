#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define STRING "Hello world"
#define MAX_LEN "1000"
#define ENDL "\n\t"

extern void copy(char *, char *, int);

size_t my_asm_strlen(char *string)
{
	size_t len = 0;

	asm(".intel_syntax noprefix\n\t" // директива GAS, включаем Intel синтаксис.
		"lea rdi, [%1]" ENDL		 // команда LEA выполняет вычисление адреса второго операнда и записывание его в первый операнд
		"mov rcx, " MAX_LEN ENDL
		"CLD" ENDL		   // DF = 0.
		"mov al, 0" ENDL   // Терминирующий символ.
		"repne scasb" ENDL // Выполняем повторение.
		"mov rax, " MAX_LEN ENDL
		"sub rax, rcx" ENDL
		"dec rax" ENDL	   // Т.к. посчитает и терминирующий символ.
		"mov %0, rax" ENDL // Записываем в len.
		: "=r"(len)		   // список выходных параметров. (r == register (Т.е. записать в регистр))
		: "r"(string)	   // список входных параметров.
		: "eax");		   // список разрушаемых регистров.

	return len;
}

char *create_string(char *str)
{
	return malloc(sizeof(char) * strlen(str) + 1);
}

int main(int argc, char *argv[])
{
    setbuf(stdout, NULL);
	size_t len = 0;
	char *string_user = create_string(argv[1]);
	char *string_result = create_string(argv[1]);

	strcpy(string_user, argv[1]);

	len = my_asm_strlen(string_user);

	printf("strlen:\nC: %ld\nMy: %ld\n", strlen(string_user), len);

	copy(string_result, string_user, len);

	printf("Copy: %s\n", string_result);

	free(string_user);
	free(string_result);

	char string[20] = "123456";
	len = strlen(string);
	printf("string = %s", string);
	copy(string, string + 3, 3);
	printf("\nstring = %s\n", string);

	char string_reverse[20] = "123456";
	len = strlen(string_reverse);
	printf("string_reverse = %s", string_reverse);
	copy(string_reverse + len, string_reverse, len);
	printf("\nstring_reverse = %s\n", string_reverse);
}