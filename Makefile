# Usage: type 'make' in terminal to build and run
all:
	nasm -f elf64 linux-x86_64-tic-tac-toe.nasm -o linux-x86_64-tic-tac-toe.o
	ld linux-x86_64-tic-tac-toe.o -o linux-x86_64-tic-tac-toe
	./linux-x86_64-tic-tac-toe

clean:
	rm *.o linux-x86_64-tic-tac-toe