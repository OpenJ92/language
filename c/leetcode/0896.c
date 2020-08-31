bool isMonotonicGeneric(int* A, int ASize, int (*compare)(int, int)) 
{    
    int x = 0;
    bool res = true;
    
    for (x; x < (ASize - 1); x++) 
    {      
        if (compare(A[x], A[x + 1])) 
        {           
            res = false;           
            break;      
        }   
    }  
    return res;
}

int greaterThan(int a, int b) 
{  
    return a > b;
}

int lessThan(int a, int b) 
{
    return a < b;
}

bool isMonotonic(int* A, int ASize) 
{
    return isMonotonicGeneric(A, ASize, greaterThan) || isMonotonicGeneric(A, ASize, lessThan);
}
