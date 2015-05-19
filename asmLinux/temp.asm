

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;


segment .bss
;
; uninitialized data is put in the bss segment
;


 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;
        mov eax, 07ffffffdh
        add eax, 3
        dump_regs 1               ; dump out register values

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


