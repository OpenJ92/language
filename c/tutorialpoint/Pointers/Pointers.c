#include <stdio.h>

const int MAX = 3;

int main(){
  int var = 20;
  int var1;
  char var2[10];

  printf("Address of var1 variable: %p \n", &var1);
  printf("Address of var2 variable: %p \n", &var2);
  printf("\n");

  int * ip = &var;
  double * dp = NULL;
  char * cp = NULL;
  float * fp = NULL;

  printf("Address of var variable: %p \n", &var);
  printf("Address of ip variable: %p \n", ip);
  printf("Value if *ip variable: %d \n", *ip);
  printf("\n");

  if (!dp) {
    printf("dp pointer is null \n");
  } else {
    printf("dp pointer is not null \n");
  }
  printf("\n");

  int var3[] = {10, 100, 200};

  int *ptr = &var3[0];
  for (int i = 0; i < MAX; i++) {
    printf("Address of var3[%d] = %p\n", i, ptr);
    printf("Value of var3[%d] = %d\n", i, *ptr);
    printf("Value of var3[%d] = %d\n", i, var3[i]);
    ptr++;
  }
  printf("\n");

  int *ptr1 = &var3[MAX-1];
  for (int i = MAX-1; i >= 0; i--) {
    printf("Address of var3[%d] = %p\n", i, ptr1);
    printf("Value of var3[%d] = %d\n", i, *ptr1);
    printf("Value of var3[%d] = %d\n", i, var3[i]);
    ptr1--;
  }
  printf("\n");

  return 0;
}
