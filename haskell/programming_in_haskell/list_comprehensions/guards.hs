-- Guards:
--
-- List comprehensions can also use logical expressions to 
-- filter the generator sets given. A quick example follows

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f x]

factors' :: Int -> [Int]
factors' n = [x | x <- [1..n], mod n x == 0] 

prime' :: Int -> Bool
prime' n = factors' n == [1, n]

primes' :: Int -> [Int]
primes' n = [ x | x <- [2..n], prime' x ]

primes'' :: Int -> [Int]
primes'' n = filter' prime' [2..n]

find' :: Eq a => a -> [(a, b)] -> [b]
find' x xys = [y | (x', y) <- xys, x' == x]
-- Guards:
--
-- List comprehensions can also use logical expressions to 
-- filter the generator sets given. A quick example follows

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f x]

factors' :: Int -> [Int]
factors' n = [x | x <- [1..n], mod n x == 0] 

prime' :: Int -> Bool
prime' n = factors' n == [1, n]

primes' :: Int -> [Int]
primes' n = [ x | x <- [2..n], prime' x ]

primes'' :: Int -> [Int]
primes'' n = filter' prime' [2..n]

find' :: Eq a => a -> [(a, b)] -> [b]
find' x xys = [y | (x', y) <- xys, x' == x]
