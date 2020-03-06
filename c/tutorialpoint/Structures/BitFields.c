#include <stdio.h>
#include <stdlib.h>
#include "BitFields.h"

int main () {
  packed_struct* p1 = new(0, 0, 0, 0, 4, 4, method);
  printf("%p\n", p1);
  printf("%p\n", new);
  printf("%p\n", p1->ptrfunc);
  p1->ptrfunc(1);
  printf("sizeof(p1) = %lu\n", sizeof(p1));
  return 0;
}

packed_struct* new(
    unsigned int f1,
    unsigned int f2,
    unsigned int f3,
    unsigned int f4,
    unsigned int type,
    unsigned int ny_int,
    void *ptrfunc) {
  packed_struct* p = malloc(sizeof(packed_struct));
  p->f2 = f2;
  p->f3 = f3;
  p->f4 = f4;
  p->f1 = f1;
  p->type = type;
  p->ny_int = ny_int;
  p->ptrfunc = ptrfunc;
  return p;
}

void method(int a){
  printf("%d\n", a);
}
