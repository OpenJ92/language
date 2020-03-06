#include <stdio.h>

int main(){
  int count = 5;

  // while loop
  while (count--){
  }

  // for loop
  for (int i = 1; i < 10; i++){
  }

  // do ... while
  do {
  } while(count--);

  // nested loop
  for (int i = 1; i < 10; i++){
    for (int j = 1; j < 10; j++){
          printf("(%d, %d)\n", i, j);
        }
      }

  // Loop control statements
  // break; when executed, termination of the loop is forced.
  printf("\nbreak:\n");
  for (int i = 1; i < 10; i++){
    for (int j = 1; j < 10; j++){
      printf("(%d, %d)\n", i, j);
      }
      if (i == 3){
        break;
      }
    }
  
  
  // continue; when executed, execution of the next iteration of the loop is forced.
  printf("\ncontinue:\n");
  for (int i = 1; i < 10; i++){
    for (int j = 1; j < 10; j++){
      printf("(%d, %d)\n", i, j);
      }
      if (i == 3) {
        i++;
        continue;
    }
  }

  // goto;
  printf("\ngoto:\n");

  return 0;
}
