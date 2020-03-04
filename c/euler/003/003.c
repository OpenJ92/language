#include <math.h>
#include <stdio.h>
#include "003.h"

int main ()
{ 
  int i = 0;
  int *iptr = &i;
  long long int array[100];
  long long int *ptr_array_ = array;
  long long int n = 600851475143LL;
  long long int *q = prime_factor(n, 2, ptr_array_, iptr);
  for (int j = 0; j <= i; j++)
  {
    printf("array[%i] = %lli\n",j,*(q+j));
  }
}

long long int *prime_factor (long long int num, long long int factor, long long int (*factors), int *index)
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

long long int is_prime (long long int num)
{
  if (num == 2) { return 1; }
  else if (num % 2 == 0) { return 0; }
  for (int i = 3; i <= sqrt(num); i += 2) { if (num % i == 0) { return 0; } }
  return 1;
}
