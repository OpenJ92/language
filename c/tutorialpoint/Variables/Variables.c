#include <stdio.h>

extern int i, j, k;
extern float d;

int func(void);
float div(float, float);

int main(int argc, char** argv) {

  int i, j, k;
  float d;

  i = 10;
  j = 20;
  k = 30;

  int c = i + j + k;
  printf("value of c: %d \n", c);

  d = 70.0 / 30.0;
  printf("value of d: %f \n", d);

  float q = func() + div(k, j);
  printf("value of q: %f \n", q);

  return 0;
}

int func(){
  return 100;
}

float div(float int_1, float int_2){
  return int_1 / int_2;
}
