#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "MemoryManagement.h"

int main () {
  test_calloc();
  test_free();
  test_malloc();
  test_realloc();
  return 0;
}

void test_calloc(void){
  void *A = calloc(8, 2);
}

void test_free(void){
  void *B = calloc(8, 2);
  free(B);
}

void test_malloc(void){
  void *C = malloc(8);
}

void test_realloc(void){
  void *D = malloc(8);
  void *E = realloc(D, 32);
}

void print_information(void *L){
  printf("sizeof(L) = %lu\n", sizeof(L));
  printf("L = %p\n", L);
  printf("&L = %p\n\n", &L);
}

