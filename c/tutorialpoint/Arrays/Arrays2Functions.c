#include <stdio.h>

void myFunction1(int *param);
void myFunction2(int param[10]);
void myFunction3(int param[], int size);

int main () {
  int array[10] = {1,2,3,4,5,6,7,8,9,0};
  int array_[3] = {myFunction1, myFunction2, myFunction3};
  int *ptr2func[3];
  myFunction2(array);
  myFunction3(array, 10);

  for (int i = 0; i < 3; i++) {
    printf("myFunction%d address = %p \n", i, array_[i]);
    ptr2func[i] = array_[i];
    printf("ptr2func[%d] address = %p \n", i, ptr2func[i]);
  }

  printf("%p \n", &myFunction2);
  printf("%p \n", myFunction2);
  return 0;
}

void myFunction1(int *param) {
  // *param is a pointer.
  return;
}

void myFunction2(int param[10]) {
  // param[10] is an initialized array.
  for (int i = 0; i < 10; i++) {
    printf("value of param[%d] = %d \n", i, param[i]);
  }
  return;
}

void myFunction3(int param[], int size) {
    // param[] is a variable array.
    return;
}
