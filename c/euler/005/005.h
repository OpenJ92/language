#ifndef HEADER_005
#define HEADER_005

long long int* prime_factor(long long int num, 
                            long long int factor,
                            long long int (*factors),
                            int *index);

long long int is_prime (long long int num);

void factor_intersection(int num, int factor);

#endif
