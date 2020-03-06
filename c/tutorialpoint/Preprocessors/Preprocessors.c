#include <stdio.h>
#include "Preprocessors.h"
#include "myheader/myheader.h"

int main () {
  printf("FILE_SIZE content :%d\n", FILE_SIZE);
  printf("MESSAGE content :%s\n", MESSAGE);

  printf("File :%s\n", __FILE__ );
  printf("Date :%s\n", __DATE__ );
  printf("Time :%s\n", __TIME__ );
  printf("Line :%d\n", __LINE__ );
  printf("ANSI :%d\n", __STDC__ );

  hello();
  goodbye();

  return 0;
}

void hello(void){ 
  printf("Hello, World!\n");
}

void goodbye(void){
  printf("Goodbye, World.\n");
}
