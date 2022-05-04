#include <stdio.h>
#include <stdlib.h>

// Declara função implementada no arquivo .asm
extern int calculateBcd(char, char, char);

int main() {
    printf("10 + 4  = %x\n", calculateBcd(0x10, '+', 0x04));
    printf("31 + 57 = %x\n", calculateBcd(0x31, '+', 0x57));
    printf("63 + 48 = %x\n", calculateBcd(0x63, '+', 0x48));
    printf("5  - 2  = %x\n", calculateBcd(0x05, '-', 0x02));
    printf("3  - 8  = %x\n", calculateBcd(0x03, '-', 0x08));
    printf("63 - 68 = %x\n", calculateBcd(0x63, '-', 0x68));
    printf("43 - 24 = %x\n", calculateBcd(0x43, '-', 0x24));
    return 0;
}

// para compilar e executar o programa, execute:
/* 
nasm -f elf32 -o calcula.o calcula.asm
gcc -m32 -c -o c_chama.o c_chama.c
gcc -m32 -o run calcula.o c_chama.o; ./run
*/
