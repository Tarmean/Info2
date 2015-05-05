

;
; file: first.asm
; First assembly program. This program asks for two integers as
; input and prints out their sum.
;
; To create executable:
; Using djgpp:
; nasm -f coff first.asm
; gcc -o first first.o driver.c asm_io.o
;
; Using Linux and gcc:
; nasm -f elf first.asm
; gcc -o first first.o driver.c asm_io.o
;
; Using Borland C/C++
; nasm -f obj first.asm
; bcc32 first.obj driver.c asm_io.obj
;
; Using MS C/C++
; nasm -f win32 first.asm
; cl first.obj driver.c asm_io.obj
;
; Using Open Watcom
; nasm -f obj first.asm
; wcl386 first.obj driver.c asm_io.obj

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
name db    "Cyril", 0       ; don't forget nul terminator

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; push ebp to stack, move esp to ebp so stack is available without worries
;then reduce ebp by the amount that it is supposed to allocate
; First 0 for amount of stack space to allocate, second one for nesting level
        pusha 		;either pushaw or pushad, in case of 32 bit:
;pushes EAX, ECX, EDX, EBX, ESP(before instruction), EBP, ESI and EDI in succession and decrements esp by 32

        mov     eax, name      ; print out name
        call    print_string
	call 	print_nl

        popa 		;restore registers saved by pusha
;Note that it throws the value of ESP away
        mov     eax, 0            ;set return value
        leave            ;move ebp to esp, restore ebp from stack         
        ret


