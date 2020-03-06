#include <stdio.h>

const int MAX = 3;

int main () {
  int var[MAX] = {10, 100, 200};
  int i;
  int *ptr[MAX];

  for (i = 0; i < MAX; i++) {
    ptr[i] = &var[i];
  }

  for (i = 0; i < MAX; i++) {
    printf("value of var[%d] = %d\n", i, *ptr[i]);
  }

  char *names[] = {
    "Zara Ali",
    "Hina Ali",
    "Nuhu Ali",
    "Bill Ali"
  };

  for (i = 0; i < 4; i++) {
    printf("Value of names[%d] = %s \n", i, names[i]);
  }

  return 0;
}
