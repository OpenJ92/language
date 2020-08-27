#incldue <stdio.h>

int addDigits(int num)
{
    int digit_sum = 0;
    
    if (num < 10) { return num; }

    while (num > 0)
    {
        digit_sum += num % 10;
        num = num / 10;
    }
    
    return addDigits(digit_sum);
}
