#ifndef HEADER_FILE
#define HEADER_FILE

typedef struct packed_struct {
  unsigned int f1:1;
  unsigned int f2:1;
  unsigned int f3:1;
  unsigned int f4:1;
  unsigned int type:4;
  unsigned int ny_int:9;
  void (*ptrfunc)(int a);
} packed_struct;

packed_struct* new(
    unsigned int f1,
    unsigned int f2,
    unsigned int f3,
    unsigned int f4,
    unsigned int type,
    unsigned int ny_int,
    void (*ptrfunc)
    ); 

void method(int a);

#endif
