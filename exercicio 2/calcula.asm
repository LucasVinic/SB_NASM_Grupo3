SECTION .text

extern printf
global calculateBcd

calculateBcd:
	push 	ebx
	mov	 	eax, [esp+8]        ; param 1
	mov	 	ebx, [esp+12]       ; param 2 '-' '+'
	mov	 	ecx, [esp+16]       ; param 3

	; IF ebx = '-' (45)
	cmp ebx, '-'
	jz is_sub
		; salva o dígito superior em ebx e edx
		mov ebx, eax
		and ebx, 0xFFF0
		mov edx, ecx
		and edx, 0xFFF0

		; salva dígito inferior em eax e ecx
		and eax, 0x000F
		and ecx, 0x000F

		; soma dígito inferior
		add eax, ecx

		; se resultado é < 9, ok
		cmp eax, 10
		jl sum_upper_digit

		; caso contrário, tire 10 dos dígitos menores e some 1 nos superiores
		sub eax, 10
		add ebx, 0x10

		; soma dígito superior
		sum_upper_digit:
		add ebx, edx

		; se dígito superior acima de 10, subtrai 10
		cmp ebx, 0x00A0
		jl end_is_add

		sub ebx, 0xA0

		end_is_add:
		; join upper and lower digits
		or eax, ebx
		jmp end_is_sub

	; ELSE
	is_sub:
		; salva o dígito superior em ebx e edx
		mov ebx, eax
		and ebx, 0xFFF0
		mov edx, ecx
		and edx, 0xFFF0

		; salva dígito inferior em eax e ecx
		and eax, 0x000F
		and ecx, 0x000F

		; if doesn't need to borrow, just sub
		cmp eax, ecx
		jg lower_digit_sub

		; if upper digit = 0, underflow
		cmp ebx, 0
		jg dont_underflow
		add ebx, 0xA0
		dont_underflow:

		; borrow-1
		sub ebx, 0x10
		add eax, 10

		lower_digit_sub:
		sub eax, ecx

		; if ebx < edx, underflow
		cmp ebx, edx
		jg upper_digit_sub

		; underflow
		add ebx, 0xA0

		upper_digit_sub:
		sub ebx, edx

		cmp ebx, 0xA0
		jl dont_do_anything
		sub ebx, 0xA0

		dont_do_anything:
		; join digits
		or eax, ebx

	end_is_sub:
	; END ELSE
	pop ebx
	ret
