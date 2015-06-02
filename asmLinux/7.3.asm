

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
;
; uninitialized data is put in the bss segment
;




segment .text
        global euclid
        global asm_main

asm_main:
        push ebp                ;store old stack position
        push ebx                ;store veriables that are changed
        push edx
        mov ebp, esp
        mov eax, [ebp+16]       ;load parameters
        mov ebx, [ebp+20]


        mov edx, 0              ;do the modulo
        div ebx                 ;i am too lazy to do so but it would probably
                                ;be significantly faster to divide with ex and ax 


        mov eax, ebx            ;move return value to eax
        cmp edx, 0              ;if no remainder remains return
        je return

        push edx                ;recursion
        push ebx
        call asm_main
        add esp, 8              ;take parameters from stack, should be faster than popping?


return:
        
        pop edx                 ;restore parameters except eax
        pop ebx
        pop ebp
        ret

;euclid(a, b)
;if(b==0) return a
; return euclid(b, a mod b)

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
;  answer = asm_main(a1,a2);
;  printf("Antwort:%d %d %d\n",a1, a2, answer);
;  return 0;
;}
;
