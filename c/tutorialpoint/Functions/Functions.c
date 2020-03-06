#include <stdio.h>

void swap_by_value(int, int);
void swap_by_reference(int *, int *);

int main(){
  int a = 100;
  int b = 200;

  printf("a = %d, b = %d \n", a, b);
  swap_by_value(a, b);
  printf("a = %d, b = %d \n", a, b);
  swap_by_reference(&a, &b);
  printf("a = %d, b = %d \n", a, b);
  return 0;
}

void swap_by_value(int a, int b){
  int temp = a;
  a = b;
  b = temp;
}

void swap_by_reference(int *a, int *b){
  int temp = *a;
  *a = *b;
  *b = temp;
}
