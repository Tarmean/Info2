
;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;


segment .bss
returnvalue resd 1
;
; uninitialized data is put in the bss segment
;




segment .text
        global  euclid
euclid:
        enter   0,0               ; setup routine
        pusha
        mov eax, [ebp+8]          ; load parameters
        mov edx, [ebp+12]

loops:
        cmp edx, 0                ; return if rest (a) equals zero
        jz return
        mov ebx, edx              ; b = r
        mov edx, 0
        div ebx
        mov eax, ebx              ; a = b
        jmp loops                 ; jump back to loop
;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;
return:
        mov [returnvalue], ebx      ; save the return value before popa snuffs it out
        popa
        mov     eax, [returnvalue]            ; return back to C
        leave
        ret

;while(b!=0)
    ;r = a mod b
    ;a = b
    ;b = r


;#include "cdecl.h"
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;
;
;int PRE_CDECL asm_main( int, int ) POST_CDECL;
;
;int main(int argc, char *argv[])
;{
;  if(argc<3)
;  {
;      return 0;
;  }
;  int answer;
;  int a1 = atoi(argv[1]);
;  int a2 =  atoi(argv[2]);
;  answer = euclid(a1,a2);
;  printf("Antwort:%d %d %d\n",a1, a2, answer);
;  return 0;
;}
