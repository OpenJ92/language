/******************************************************************************
* File:             005.c
*
* Author:           Jacoob Vartuli-Schonberg  
* Created:          09/19/19 
* Description:      Project Euler problem 5
*****************************************************************************/

#include <stdio.h>
#include <math.h>
#include "005.h"
#include "hash.h"
#include "linked_list.h"

int main ()
{ 
  int i = 0;
  int *iptr = &i;
  long long int array[100];
  long long int *ptr_array_ = array;
  long long int m = 600851475143LL;
  long long int n = pow(2,0)*pow(3,0)*pow(5,1)*pow(7,1)*pow(11,1)*pow(13,1)*pow(17,0)*pow(23,1)*pow(29,1)*pow(31,1)*pow(37,0)*pow(41,1)*pow(43,1)*pow(47,0)*pow(53,1)*pow(59,1);
  long long int *q = prime_factor(n, 2, ptr_array_, iptr);
  for (int j = 0; j <= i; j++)
  {
    printf("array[%i] = %lli\n",j,*(q+j));
  }
}

long long int is_prime (long long int num)
{
  if (num == 2) { return 1; }
  else if (num % 2 == 0) { return 0; }
  for (int i = 3; i <= sqrt(num); i += 2) { if (num % i == 0) { return 0; } }
  return 1;
}

long long int *prime_factor (long long int num,
                             long long int factor,
                             long long int (*factors),
                             int *index)
{
  if (is_prime(num))
    {
      *(factors + *index) = num;
      return factors; 
    }
  else if (num % factor == 0 && is_prime(factor))
    {
      num = (long long int)(num/factor);
      *(factors + *index) = factor;
      *index += 1;
      return prime_factor((long long int)num, (long long int)factor, factors, index);
    }
  else
    {
      factor += 1;
      return prime_factor((long long int)num, (long long int)factor, factors, index);
    }
}
