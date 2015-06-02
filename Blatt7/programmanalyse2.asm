%include "asm_io.inc"

segment .data		
	eingabe1 db "Geben Sie die untere Schranke a ein: ", 0
	eingabe2 db "Geben Sie die obere Schranke b ein: ", 0
	fehler1 db "Achtung: b<a nicht erlaubt! ", 0
	fehler2 db "Achtung: b<0 nicht erlaubt! ", 0
	fehler3 db "Achtung: a<0 nicht erlaubt!", 0
	ausgabetext db "Das Ergebnis s lautet: ", 0

segment .text
	global asm_main

asm_main:
	enter 0,0					
	pusha						
	mov eax, eingabe1			
	call print_string
	call read_int				
	mov ebx, eax				
	cmp ebx,0					
	jl error3					
	mov eax, eingabe2			
	call print_string
	call read_int				
	mov ecx, eax				
	cmp ecx,0					
	jl error2					
	cmp ecx, ebx				
	jl error1					
	mov edx, 0					
								
while:							
	cmp ebx, ecx				
	je whileEnd					
	mov eax, ebx			
	imul eax, ebx				
	imul eax, ebx
	add edx, eax				
	inc ebx						
	jmp while					

whileEnd:	
	mov eax, ebx		
	imul eax, ebx				
	imul eax, ebx
	add edx, eax				
	mov eax, ausgabetext		
	call print_string
	mov eax, edx				
	call print_int
	jmp end

error1:
	mov eax, fehler1			
	call print_string
	jmp end

error2:
	mov eax, fehler2			
	call print_string
	jmp end

error3:
	mov eax, fehler3			
	call print_string
	jmp end

end:
	call print_nl
	
	popa                        
	mov eax, 0					
	leave 						
	ret
