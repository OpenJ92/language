#include <stdio.h>
#include <string.h>

int main() {
  char greeting[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
  char greeting_[] = "Hello!";

  printf("Greeting message: %s \n", greeting_);

  char str1[12] = "Hello";
  char str2[12] = "World";
  char str3[12];
  int len;

  strcpy(str3, str1);
  printf("strcpy(str3, str1) :  %s\n", str3);

  strcat(str1, str2);
  printf("strcat(str1, str2) : %s\n", str1);

  len = strlen(str1);
  printf("strlen(str1) = %i\n", len);

  return 0;
}

