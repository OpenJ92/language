#ifndef p001_HEADER
#define p001_HEADER

int* range(int start, int end);
int is_divisible(int num, int dem);
int* list_multiples(const int* list, const int* factors,
                    const int length_list,const int length_factors,
                    int* count);
int sum_list_multiples(const int* list, int length_list);

#endif
