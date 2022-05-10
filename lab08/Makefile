#FLAGS := -S
FLAGS := -Wall -g -masm=intel 

app.out: main.c copystr.asm
	nasm -felf64 copystr.asm -o copystr.o 
	gcc $(FLAGS) -c main.c -o main.o
	gcc -o app.out main.o copystr.o
	rm *.o

run:
	./app.out  "Hello world"

gdb:
	gdb -q ./app.out

clean:
	rm -f *.o *.exe *.out   