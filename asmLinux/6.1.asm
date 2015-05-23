

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
prompt1 db    "Enter the Adress: ", 0
prompt2 db    "The row is: ", 0



segment .bss
input resd 1



segment .text
        global  asm_main
asm_main:
        enter   0,0                                                     ; setup routine
        pusha

        mov eax, prompt1                                                ; print prompt
        call print_string

        call read_int                                                   ; read integer to eax
        mov ebx, eax

        shr ebx, 4                                                      ; move 4 bits to the right

        mov eax, prompt2                                                ; print prompt and result
        call print_string
        mov eax, ebx
        call print_int



        popa
        mov     eax, 0                                                  ; return back to C
        leave
        ret


