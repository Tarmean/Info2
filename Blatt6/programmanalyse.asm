%include "asm_io.inc"

segment .data		
	codewort1 dd 11000110b
	codewort2 dd 11010011b
	outputMsg db "Ergebnis: ", 0

segment .text
	global asm_main

asm_main:
	enter 0,0		        ;save stack position, push registers onto the stack yada yada
	pusha			

	mov ebx, 0xffffffff		;First complement, xor 198, -1 = -199 
	xor ebx, [codewort1] 	
	mov ecx, 0xffffffff		
	xor ecx, [codewort2]	;First Complement, xor 211, -1 = -212

	xor ebx, ecx		    ; xor -199, -212 = 21
                            ; Binary form: 00000000000000000000000000010101  
						
	mov eax, ebx		
	call print_int
	call print_nl

	mov ecx, 32	
	mov edx, 0	

loopBegin:
	shl ebx, 1	
	jnc skipInc	
	inc edx		            ; Test every digit of 00000000000000000000000000010101 except the first one and increase edx whenever a 1 is found
	
skipInc:
	loop loopBegin	        ; ecx--, if ecx > 0 jump to loopBegin, I think that loops 31 times?

	mov eax, outputMsg	    
	call print_string

	mov eax, edx		    ; Number of 1's found
	call print_int
	call print_nl

	popa                    ; the usual return stuff
	mov eax, 0
	leave 
	ret


