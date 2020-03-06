#include <stdio.h>

int main() {
  int var;
  int *ptr;
  int **pptr;
  int ***ppptr;
  int ****pppptr;

  var = 3000;
  ptr = &var;
  pptr = &ptr;
  ppptr = &pptr;
  pppptr = &ppptr;

  printf("Value of var = %d\n", var );
  printf("Value available at *ptr = %d\n", *ptr );
  printf("Value available at **pptr = %d\n", **pptr);
  printf("Value available at ***ppptr = %d\n", ***ppptr);
  printf("Value available at ****pppptr = %d\n", ****pppptr);

  return 0;
}
