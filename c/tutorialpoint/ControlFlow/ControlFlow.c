#include <stdio.h>

int main(){
  // if statement
  int condition = 1;
  if (condition == 1) {printf("In if statement. \n");}

  // if - else statement
  if (condition == 0) {printf("In if statement. \n");} else {printf("In else statement. \n");}
  printf("%d \n",(1 == 2) ? 3 : 4);

  // if - else if - else statement
  if (condition == 0) {
  } else if (condition == 1) {
  } else if (condition == 2) {
  } else if (condition == 3) {
  } else {
  }

  // nested if statement
  if (condition == 1) {
    if (condition == 0) {
    }
  }
  return 0;

  // switch statements
  //  Note: There exists the posibility to use nested switched.
  switch (condition) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
  }
}
