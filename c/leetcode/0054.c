int maxSubArray(int* nums, int numsSize){
    if (numsSize <= 0) { return NULL; }
    if (numsSize == 1) { return nums[0]; }
    
    int maxSum = nums[0];
    int runningSum = nums[0];
    for (int i = 1; i < numsSize; i++)
    {
        
        runningSum = 
            (nums[i] > (runningSum + nums[i])) 
            ? nums[i] 
            : runningSum + nums[i];
        
        maxSum = 
            maxSum > runningSum 
            ? maxSum 
            : runningSum;
    }
    
    return maxSum;
}
