

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
prompt1 db    "Enter the Adress: ", 0
prompt2 db    "The row is: ", 0
prompt3 db    "The tag is: ", 0
error   db    "The Adress has to be between 0 and 65535", 0



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

        test eax, 11111111111111110000000000000000b                     ;is anything but the first 16 bit set? Dirty tricks because I am too lazy to find the right jump instruction for unsigned comparisons
        jnz abort

                                                                        ;  I hope ccccccccrrraawwb is the right thingy 
        shr eax, 5                                                      ; move 4 bits to the right. leaving ccccccccrrr 
        mov ebx, eax
        and ebx, 00000000000000000000000000000111b                      ; mask the rest out, leaving rrr

        shr eax, 3                                                      ; move 3 bits to the right. Leaving cccccccc 
        mov ecx, eax

        mov eax, prompt2                                                ; print prompt and result
        call print_string                                                   
        mov eax, ebx
        call print_int
        call print_nl

        mov eax, prompt3                                                ; print prompt and result
        call print_string                                                   
        mov eax, ecx
        call print_int
        call print_nl


        popa
        mov     eax, 0                                                  ; return back to C
        leave
        ret

abort:

        mov eax, error                                                ; print prompt and result
        call print_string                                                   
        call print_nl
        popa
        mov     eax, 0                                                  ; return back to C
        leave
        ret
