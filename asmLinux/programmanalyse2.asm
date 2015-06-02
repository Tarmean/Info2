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
	enter 0,0           ;the usual stuff
	pusha
	mov eax, eingabe1   ;input prompt
	call print_string
	call read_int
	mov ebx, eax
	cmp ebx,0           ;abort if a < 0
	jl error3
	mov eax, eingabe2   ;input prompt
	call print_string
	call read_int
	mov ecx, eax
	cmp ecx,0           ;abort if b < 0
	jl error2
	cmp ecx, ebx        ;abort if b < a
	jl error1
	mov edx, 0

while:
	cmp ebx, ecx        ;while a!=b
	je whileEnd
	mov eax, ebx
	imul eax, ebx       ;eax = a ^ 3
	imul eax, ebx
	add edx, eax        ;edx += eax
	inc ebx             ;a++
	jmp while

whileEnd:
	mov eax, ebx        ; one last time
                        ; changing the loop-jump to jnbe (not below or equal) would
                        ; allow to remove this part!
                        ; (alternatively switch the compare and jl)
	imul eax, ebx
	imul eax, ebx
	add edx, eax
    ;int temp = 0;
    ;for ( int i = a, a<=b, a++)
    ;temp += a^3
	mov eax, ausgabetext
	call print_string
	mov eax, edx
	call print_int
	jmp end
;print error message and end respectively
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
