#include <stdio.h>
#include <string.h>

union Data {
  int i:1;
  float f;
  char str[20];
};

// Note: Unions can store only one of it's members at it's 
// address at a time.

int main() {
  union Data data;
  printf("Memory size occupied by data: %lu \n", sizeof(data));

  data.i = 0;
  printf( "data.i : %d\n", data.i);

  data.f = 1.0;
  printf( "data.f : %f\n", data.f);

  strcpy(data.str, "C Programming");
  printf( "data.str : %s\n", data.str);

  return 0;
}
