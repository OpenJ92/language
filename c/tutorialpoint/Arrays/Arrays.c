#include <stdio.h>

int main(){
  int array[4] = {0,1,2,3};
  int matrix[4][4] = {{0,1,2,3}, {0,1,2,3}, {0,1,2,3}, {0,1,2,3}};

  for (int i = 0; i < 4; i++){
    for (int j = 0; j < 4; j++){
      printf("a[%d][%d] = %d ", i, j, matrix[i][j]);
    }
    printf("\n");
  }
  return 0;
}
