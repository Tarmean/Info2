#include "cdecl.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int PRE_CDECL asm_main( int, int ) POST_CDECL;

int main(int argc, char *argv[])
{
  if(argc<3)
  {
      return 0;
  }
  int answer;
  int a1 = atoi(argv[1]);
  int a2 =  atoi(argv[2]);
  answer = euclidRec(a1,a2);
  printf("Antwort:%d %d %d\n",a1, a2, answer);
  return 0;
}
