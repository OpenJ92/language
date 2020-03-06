#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "VariableArguments.h"

int main () {
  double avg_1 = average(5,1,2,3,4,5);
  double avg_2 = average(6,1,2,3,4,5,6);
  double avg_3 = average(7,1,2,3,4,5,6,7);
  double avg_4 = average(8,1,2,3,4,5,6,7,8);

  printf("average(5,1,2,3,4,5) = %f\n", avg_1);
  printf("average(6,1,2,3,4,5,6) = %f\n", avg_2);
  printf("average(7,1,2,3,4,5,6,7) = %f\n", avg_3);
  printf("average(8,1,2,3,4,5,6,7,8) = %f\n", avg_4);
  return 0;
}

int func(int x, ...){
  return 0;
}

double average(int num, ...){
  va_list valist;
  double sum; int i;

  va_start(valist, num);

  for(i = 0; i < num; i++){
    sum += va_arg(valist, int);
  }

  va_end(valist);
  return sum / num;
}
