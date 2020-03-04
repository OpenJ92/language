#ifndef hash_table_HEADER
#define hash_table_HEADER

typedef struct DataItem 
{
  int data;
  int key;
  int is_null_obj;
}
DataItem;

typedef struct HashTable
{
  int size;
  DataItem* hashArray;
  DataItem* dummyItem;
}
HashTable;

int hashCode(HashTable* hash_table, int key);
DataItem* search(HashTable* hash_table, int key);
void insert(HashTable* hash_table, int key, int data);
DataItem* delete(HashTable* hash_table, DataItem* item);
void display_hash(HashTable* hash_table);
void display_item(DataItem* item);
void change_size(HashTable* hash_table, int delta_size);

DataItem* dataItemInit(int key, int data, int is_null_obj);
HashTable* hashTableInit(int size);

#endif
