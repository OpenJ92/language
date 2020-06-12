primes :: [Int]
primes = seive [2..]

seive :: [Int] -> [Int]
seive (p:xs) = p : seive [ x | x <- xs , mod x p /= 0 ]
