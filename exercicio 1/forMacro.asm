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

%macro forLoop 2
  %push forLoop

  inicializar %1

  _loop:
  ; do stuff
  mov eax, ecx
  call print_int
  mov eax, newline
  call print_string
  ; do stuff
  add ecx, 1    ; decrementa o contador
  cmp ecx, %2    ; compara o contador com 0
  jz _endLoop   ; se a flag for acionada, termina o loop
  jmp _loop     ; Se não tiver a flag, continua o loop
  _endLoop:
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

forLoop 5, 10 ; itera por n vezes, n = 10

popa
mov	eax, 0
leave
ret