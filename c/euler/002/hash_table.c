#include <stdlib.h>
#include <stdio.h> 

#include "hash_table.h"

HashTable* hashTableInit (int size)
{
  HashTable* hash_table = (HashTable*)malloc(sizeof(HashTable));
  hash_table->hashArray = (DataItem*)malloc(sizeof(DataItem)*size);
  hash_table->dummyItem = dataItemInit(-1, -1, 1);
  hash_table->size = size;
  for (int i = 0; i < size; i++)
  {
    hash_table->hashArray[i] = *hash_table->dummyItem;
  }
  return hash_table;
}

DataItem* dataItemInit (int key, int data, int is_null_obj)
{
  DataItem* item = (DataItem*)malloc(sizeof(DataItem));
  item->data = data;
  item->key = key;
  item->is_null_obj = is_null_obj;
  return item;
}

DataItem* search (HashTable* hash_table, int key)
{
  int hashIndex = hashCode(hash_table, key);
  while ( (hash_table->hashArray + hashIndex)->is_null_obj != 1 )
  {
    if ( (hash_table->hashArray + hashIndex)->key == key )
    {
      return hash_table->hashArray + hashIndex;
    }
    hashIndex++;
    if ( hashIndex >= hash_table->size )
    {
      return NULL;
    }
    hashIndex %= hash_table->size;
  }
  return NULL;
}

void insert (HashTable* hash_table, int key, int data)
{
  DataItem* item = dataItemInit(key, data, 0);
  int hashIndex = hashCode(hash_table, key);
  while ( (hash_table->hashArray + hashIndex)->is_null_obj != 1 )
  {
    hashIndex++;
    if (hashIndex == hash_table->size)
    {
      change_size(hash_table, 1);
    }
  }
  hash_table->hashArray[hashIndex] = *item;
  return;
}

DataItem* delete (HashTable* hash_table, DataItem* item)
{
  int key = item->key;
  int hashIndex = hashCode(hash_table, key);
  while ( (hash_table->hashArray + hashIndex)->is_null_obj != 1 )
  {
    if ( (hash_table->hashArray + hashIndex)->key == key )
    {
      DataItem* temp = hash_table->hashArray + hashIndex;
      (hash_table->hashArray)[hashIndex] = *hash_table->dummyItem;
      return temp;
    }
    hashIndex++;
    hashIndex %= hash_table->size;
  }
  return NULL;
}

void change_size( HashTable* hash_table, int delta_size )
{
  int size = hash_table->size;
  hash_table->hashArray = (DataItem*)realloc(
                                             hash_table->hashArray,
                                             sizeof(DataItem)*((hash_table->size + delta_size))
                                             );
  hash_table->size = size + delta_size;
  for (int i = size; i < hash_table->size; i++)
  {
    hash_table->hashArray[i] = *hash_table->dummyItem;
  }
}

void display_hash(HashTable* hash_table)
{
  for (int i = 0; i < hash_table->size; i++)
  {
    if ((hash_table->hashArray + i)->key != -1)
    {
      display_item(hash_table->hashArray + i);
    }
    else
    {
      printf("*(~, ~) %i \n", hash_table->hashArray[i].is_null_obj);
    }
  }
}

void display_item(DataItem* item)
{
  printf("(%i, %i)\n", item->key, item->data);
}

int hashCode (HashTable* hash_table, int key)
{
  return key % hash_table->size;
}
