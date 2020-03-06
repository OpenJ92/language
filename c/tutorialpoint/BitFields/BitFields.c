#include <stdio.h>
#include <string.h>

struct gameState{
  unsigned int map_location:1;
  unsigned int map_events:1;
};

struct gameState_{
  unsigned int map_location;
  unsigned int map_events;
};

int main(){

  struct gameState gs;
  struct gameState_ gs_;

  printf( "Memory size occupied by gs : %lu\n", sizeof(gs));
  printf( "Memory size occupied by gs_ : %lu\n", sizeof(gs_));
  return 0;
}
