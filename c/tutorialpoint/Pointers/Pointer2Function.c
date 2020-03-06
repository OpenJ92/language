#include <stdio.h>
#include <time.h>

void getSeconds(unsigned long *par);
double getAverage(int *arr, int size);
int * getRandom(int size);

int main(){
  unsigned long second;
  getSeconds(&second);
  printf("Number of seconds: %ld\n", second);
  
  int balance[5] = {1000, 2, 3, 17, 50};
  double avg = getAverage(balance, 5);
  printf("Average value is: %f\n", avg);

  int *p;
  p = getRandom(10);
  printf("%d\n", *p);

  for (int i = 0; i < 10; i++ ) {
    printf("*(p + [%d]) : %d\n", i, *(p + i) );
  }

  printf("address of function main() is :%p\n", *main);

  return 0;
}

void getSeconds(unsigned long *par) {
  *par = time(NULL);
  return;
}

double getAverage(int *arr, int size) {
  int i, sum = 0;
  double avg;

  for(i = 0; i < size; i++){
    sum += arr[i];
  }

  avg = (double)sum / size;
  return avg;
}

int * getRandom(int size) {
  int r[size];
  for (int i = 0; i < size; i++) {
    r[i] = rand();
  }
  return r;
}
