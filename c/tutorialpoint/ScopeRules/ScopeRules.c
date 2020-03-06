#include <stdio.h>

// Global Variables
int a = 50;
int func(void);

int main(){
  // Local Variables to main()
  int a = 5;
  printf("%d \n", a);
  func();
  return 0;
}

int func(void){
  // Local Variables to func()
  //    Note: There's local declaration of 'a' 
  //      in func(), so then the compiler uses 
  //      the global definition of 'a'.
  int b = 10;
  printf("%d ,%d \n", a, b);
  return a;
}
