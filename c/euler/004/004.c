#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "004.h"

int main ()
{
  int* pp = palindrome_products(); free(pp); return 0;
}

int is_palindrome(int num)
{
  int order = get_order(num);
  int* digit_list = get_digits(num);
  for (int i=order-1; i>=(int)(order/2); i=i-1)
  {
    if (digit_list[i] != digit_list[(order-1)-i])
    {
      free(digit_list); return 0;
    }
  }
  free(digit_list); return 1;
}

int* palindrome_products(void)
{
  int count = 1;
  int* palindromes = (int*)malloc(sizeof(int)*count);
  for (int i = 999; i > 99; i=i-1)
  {
    for (int j=999;j>=i;j=j-1)
    {
      if (is_palindrome(i*j))
      {
        count++;
        palindromes = (int*)realloc(palindromes, count);
        *(palindromes + count) = i*j;
        printf("(%i, %i, %i)", i, j, i*j);
      }
    }
  }
  return palindromes;
}

int get_order(int num)
{
  int order = 0;
  do
  {
    num = (float)num / (float)pow(10, 1);
    order++;
  }
  while (num >= 1);
  return order;
}
// use n mod 10 -- use integers when you're useingkkkkk

int make_number(int* digit_list, int order, int digit_num)
{
  int num = 0;
  if (digit_num != 0)
  {
    for (int pow_ = order-1; pow_ > order-digit_num-1; pow_=pow_-1)
    {
      num += digit_list[pow_] * pow(10, pow_+1);
    }
  }
  return num;
}

int* get_digits(int num)
{
  int order = get_order(num); int l_; int digit;
  int* digit_list = (int*)malloc(sizeof(int)*order);
  for (int i = order; i > 0; i = i - 1)
  {
    l_ = make_number(digit_list, order, order - i);
    int A = num / pow(10, i - 1);
    digit = (A*pow(10, i) - l_) / pow(10, i);
    digit_list[i-1] = digit;
  }
  return digit_list;
}


