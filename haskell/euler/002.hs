fib = 1 : 1 : [a+b | (a, b) <- zip fib (tail fib)]
fib_ = 1 : 1 : zipWith (+) fib_ (tail fib_)
-- There's an extrodinary slowdown on this function. Why is that the case?
bif a b = a : b : zipWith (+) (bif a b) (tail $ bif a b)

ans a = sum $ [x | x <- take a fib, even x]
ans2 a = sum $ filter even $ take a fib
ans3 a = sum $ filter even $ takeWhile (<a) fib

linspace start stop num = [start + ((stop - start)/num)*n | n <- [1..num]]

open_closed (x:xs) = xs
closed x = x
range f start stop step = f [start,start+step..stop]

factorial 0 = 1
factorial n = n * factorial (n-1)

double_factorial 0 = 1
double_factorial 1 = 1
double_factorial n = n * double_factorial (n-2)

mult 0 _ = 0
mult m n = n + mult (m-1) n
