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
prompt1 db    "Enter z: ", 0       ; don't forget nul terminator
prompt2 db    "Enter b: ", 0
warning db    "b has to be between 1 and 32", 0
outmsg1 db    "The number ", 0
outmsg2 db    " with the bit at position ", 0
outmsg3 db    " flipped is: ", 0


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resb 1

 

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
;sure you never saw these comments before...
;nothing to see here, move along :P
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt1      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input1], eax     ; store into input1

        mov     eax, prompt2      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input2],BYTE eax     ; move the first byte into input2
        mov     cl,[input2]      ; doing this directly doesn't work for some reason...
        dec     cl               ;decrease so the bit at the position of input 2 is flipped

        test    cl, cl         ; bitwise and, sets negative, zero and parity flags
        js      broken_input      ; jump if sign, i.e. if eax < 0
        cmp     cl, 32           ;actually similar to test but substracts instead of ands
        jns      broken_input      ; jump if sign, i.e. if eax > 32, note that cl is already one smaller than the input

        ;mov     eax, [input1]
        mov     ebx, 1
        shl     ebx, cl         ; now ebx is a 1 at position input2 and 0 otherwhise!
        mov     eax, [input1]
        xor     eax, ebx          ; xor that with input1
        mov     ebx, eax          ;bit annoying that the shift number has to be in ebx
;
; next print out result message as series of steps
;
        mov     eax, outmsg1
        call    print_string      ; print out first message
        mov     eax, [input1]     
        call    print_int         ; print out input1
        mov     eax, outmsg2
        call    print_string      ; print out second message
        mov     eax, [input2]
        call    print_int         ; print out input2
        mov     eax, outmsg3
        call    print_string      ; print out third message
        mov     eax, ebx
        call    print_int         ; print out sum (ebx)
        call    print_nl          ; print new-line

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

broken_input:
        mov eax, warning
        call print_string
        call print_nl
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
