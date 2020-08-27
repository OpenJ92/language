void swap(int* a, int* b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
    return;
}

void moveZeroes(int* nums, int numsSize)
{
    int slow_pointer = 0;
    
    for (int fast_pointer = 0; fast_pointer < numsSize; fast_pointer++)
    {
        if (nums[fast_pointer] != 0)
        {
            swap(&nums[slow_pointer++], &nums[fast_pointer]);
        }
    }
}
