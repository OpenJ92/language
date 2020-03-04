#include <stdio.h>
#include <stdlib.h>
#include "001.h"

int main ()
{
  int* list_range = range(1, 1000);
  int factors[2] = {3,5};
  int count = 0;
  int* l_m = list_multiples(list_range, factors, 1000, 2, &count);
  int sum = sum_list_multiples(l_m, 1000);
  for (int i = 0; i < count; i++)
  {
    printf("*(l_m + %i) = %i\n", i, *(l_m + i));
  }
  printf("sum = %i\n", sum);
  return 0;
}

int sum_list_multiples(const int* list, int length_list)
{
  int sum = 0;
  for (int i = 0; i < length_list; i++)
  {
    sum += *(list + i);
  }
  return sum;
}

int* list_multiples (const int* list, const int* factors,
                     const int length_list, const int length_factors,
                     int* count)
{
  int* list_multiples_ = (int*)malloc(sizeof(int));
  for (int i = 0; i < length_list; i++)
  {
    for (int j = 0; j < length_factors; j++)
    {
      if ( is_divisible(*(list + i), *(factors + j)) )
      {
        list_multiples_ = (int*)realloc(list_multiples_, sizeof(int)*(*count + 1));
        *(list_multiples_ + *count) = *(list + i);
        *count = *count + 1;
        break;
      }
    }
  }
  return list_multiples_;
}

int is_divisible(int num, int dem)
{
  if (num % dem == 0)
  { return 1; }
  else
  { return 0; }
}

int* range(int start, int end)
{
  int interval = end - start;
  int* list_ptr = (int*)malloc(interval*sizeof(int));
  for (int i = start; i < start+interval; i++)
  {
    *(list_ptr + i) = i;
  }
  return list_ptr;
}

