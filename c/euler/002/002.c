#include <stdlib.h>
#include <stdio.h>

#include "hash_table.h"
#include "002.h"


int main ()
{

  int sum = ub_sum(4e6, 2);
  printf("ub_sum(4e6, 2) = %i\n", sum);
}

long long int fib( int i, HashTable* hash_table )
{
  if (i == 0) { return 1; }
  if (i == 1) { return 1; }
  if (search(hash_table, i) != NULL)
  {
    return search(hash_table, i)->data;
  }
  else
  {
    int calculate = fib(i - 1, hash_table) + fib(i - 2, hash_table); 
    insert(hash_table, i, calculate);
    return calculate; 
  }
}

int factor_sum(HashTable* hash_table, int factor)
{
  int sum = 0;
  for (int i = 0; i < hash_table->size; i++)
  {
    if ( (hash_table->hashArray + i)->data % factor == 0 )
    {
      sum += (hash_table->hashArray + i)->data;
    }
    else
    {
      sum += 0;
    }
  }
  return sum;
}

int ub_sum(int ub, int factor)
{
  HashTable* hash_table = hashTableInit(5);
  int fib_ = 0; int i = 4;
  do
  {
    fib_ = fib(i, hash_table);
    i++;
  } while(fib_ < ub);
  return factor_sum(hash_table, factor);
}
