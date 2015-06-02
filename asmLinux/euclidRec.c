#include<stdio.h>

int euclid(int a, int b)
{
    if(b==0)
    {
        return a;
    }
    return euclid(b, a % b);
}
int main()
{
  int ausgabe = euclid(4,2);
  printf("Antwort: %d\n", ausgabe);
  return 0;
}

