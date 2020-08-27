int compare(int* a, int* b)
{
    if (*a > *b)
        return -1;
    else if (*a < *b)
        return 1;
    else
        return 0;
}

// i <= k
void binary_search(int* nums, int i, int k, int (*compare)(int* a, int* b), int target, int* index)
{
    printf("%i , %i\n", i, k);
    if (i == k || i > k)
    {
        if (compare(&nums[i], &target) > 0)
            *index = i + 1;
        else
            *index = i;
        return;
    }

    int j = (k + i) / 2;
    
    if (compare(&nums[j], &target) > 0)
        binary_search(nums, j+1, k, compare, target, index);
    else if (compare(&nums[j], &target) < 0)
        binary_search(nums, i, j-1, compare, target, index);
    else
        *index = j;
    return;
}

int searchInsert(int* nums, int numsSize, int target)
{
    int solution = 0;
    int* solution_ptr = &solution;
    
    binary_search(nums, 0, numsSize - 1, compare, target, solution_ptr);
    return *solution_ptr;
}
