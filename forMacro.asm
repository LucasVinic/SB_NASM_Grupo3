%include "asm_io.inc"

; declara "inicializar" com 1 parametro
; cria e pusha instancia de inicializar
; move conteudo de exc (program counter) para reg 1
; desempinha inicializar
; finaliza macro
%macro inicializar 1
	%push inicializar
	mov ecx, %1
	%pop
%endmacro

; declara "loop" com 2 parametros
; cria e pusha instancia de loop
; jnz (jump if the zero flag is not set) volta pra corpoLoop
%macro loop 2
	%push loop
	jnz corpoLoop 
%endmacro

; declara "saiLoop" com 0 parametros
; cria "saiLoop"
; desempilha saiLoop
%macro saiLoop 0
	%$saiLoop:
	%pop
%endmacro

; declara "incrementar" com 1 parametro
; cria e pusha instancia de "incrementar"
; incrementa reg %1 
; desempilha "incrementar"
%macro incrementar 1
	%push incrementar
	inc %1
	%pop
%endmacro

section .dat
newline 		db "", 0xa, 0

segment .bss

segment .text
  global  main
	main:
		enter	0,0
		pusha

inicializar 0

labelLoop:
	loop ecx, 10 ; realiza o loop 10 vezes
		corpoLoop:
			mov eax, ecx
			call print_int
			mov eax, newline
			call print_string
			incrementar ecx
			jmp labelLoop
			saiLoop

popa
mov	eax, 0
leave
ret
