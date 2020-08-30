double euclidsLength(int* a, int* b, int* pointsColSize);
double heuronsArea(int* a, int* b, int* c, int* pointsColSize);

double largestTriangleArea(int** points, int pointsSize, int* pointsColSize)
{
    double largestArea = 0; double area = 0;
    
    for (int i = 0; i < pointsSize - 2; i++)
    {
        for (int j = i + 1; j < pointsSize - 1; j++)
        {
            for (int k = j + 1; k < pointsSize - 0; k++)
            {
                area = heuronsArea(points[i], points[j], points[k], pointsColSize);
                if (area >= largestArea)
                {
                    largestArea = area;
                }
            }
        }
    return largestArea;
}

double heuronsArea(int* a, int* b, int* c, int* pointsColSize)
{
    double l, m, n, p;
    l = euclidsLength(a, b, pointsColSize);
    m = euclidsLength(b, c, pointsColSize);
    n = euclidsLength(c, a, pointsColSize);
    p = (l + m + n) / 2;
    double sqd = (double)sqrt(p * (p - l) * (p - m) * (p - n));
    return sqd;
}

double euclidsLength(int* a, int* b, int* pointsColSize)
{
    double retval = 0;
    for (int i = 0; i < *pointsColSize; i++)
    {
        retval += pow(a[i] - b[i], 2);
    }
    return sqrt(retval);
}
