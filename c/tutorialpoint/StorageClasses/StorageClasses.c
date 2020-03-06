#include <stdio.h>

void func(void);
static int count = 5;

int main(){
  // auto is the default storage class for all local variables
  int a = 0;
  auto int b = 0;

  // register is a storage class that places variables in registers over RAM.
  // This means that the variable size can be no larger than the register size.
  // Register class should only be used for variables that need to be accessed 
  // quickly. There's no garuntee that this will be stored in a register. It
  // depends on hardware implementation.
  register int c = 0;

  // the staic storage class instructs the compiler to keep a local variable
  // in existance durring the lifetime of a program instead of creating and 
  // destroying it each time it comes into and goes out of scope.
  //
  // The static moifier may also be applied to global variables. When this is
  // done, it causes that variables scope to be limited to that particular file
  // it is created in.
  static int d = 0;
  while (count--){
    func();
  }

  return 0;
}

void func(void){
  static int i = 5;
  i++;
  printf("i is %d and count is %d\n", i, count);
}
