#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "revised_004.h"

int main ()
{
  int element = 1234897;
  printf("getorder(%i) = %i\n", element, get_order(element));
  int* digits = get_digits(1234);
  for (int i = 0; i < get_order(1234); i++)
  {
    printf("%i", *(digits + i));
    printf("\n");
  }
  printf("\n");
}

int get_order(int num)
{
  int order = 0;
  do
  {
    num = num / pow(10, 1);
    order++;
  }
  while (num >= 1);
  return order;
}

int* get_digits(int num)
{
  int order = get_order(num); int index = 0;
  int* digits = (int*)malloc(sizeof(int)*order);
  do
  {
    int digit = num % 10; *(digits + index) = digit; index++;
    num = (int)(num/10);
    printf("digit = %i\n", digit);
  }
  while (num >= 1);
  return digits;
}

int is_palindrome(int num)
{
  int order = get_order(num);
  int* digits = get_digits(num);
  for (int i = 0; i <= order / 2; i++)
  {
    if (digits[i] != digits[order-i])
    {
      return 0;
    }
  }
  return 1;
}

