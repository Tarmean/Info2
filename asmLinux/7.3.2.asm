

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
abortmsg db    "Please give two arguments", 0

segment .bss
returnV resd 1
;
; uninitialized data is put in the bss segment
;




segment .text
        global asm_main

asm_main:
        ;push ebp
        ;push eax
        ;push ebx
        enter 0, 0
        pusha
        mov eax, [ebp+8]
        mov ebx, [ebp+12]
        dump_stack 1, 2, 4


        mov edx, 0
        div ebx

        push edx
        push ebx
        cmp edx, 0
        je return

        call asm_main


return:
        ;pop eax
        ;pop eax
        ;mov eax, ebx
        ;pop ebp
        pop ecx
        pop [returnV]
        dump_regs 2
        popa
        leave
        mov eax, [returnV]
        dump_regs 1
        ret

        ;euclid(a, b)
        ;if(b==0) return a
        ; return euclid(b, a mod b)


;
; code is put in the text segment. Do not modify the code before
; or after this comment.


 

exit:
        popa
        mov     eax, 0            ; return back to C
        leave
        ret
