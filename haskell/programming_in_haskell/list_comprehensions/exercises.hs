import Data.Complex
-- Exercises
--
-- 1. Using a list comprehension, give an expression that calculates
-- the sum of func of the first n integers

apply' :: (a -> b) -> [a] -> [b]
apply' f xs = [ f x | x <- xs ]

qOne :: [Int] -> Int
qOne = \xs -> (sum $ apply' (^2) xs)

-- 2. Suppose that a cooordinate of sizr m > n, use a coordinate grid 
-- where m and n are the upper bounds. 

product' :: [Int] -> [Int] -> [(Int, Int)]
product' xs ys = [ (x, y) | x <- xs, y <- ys ]

grid' :: Int -> Int -> [(Int, Int)]
grid' x y | x >= y = product' [1..x] [1..y]
          | otherwise = [(0, 0)]

-- 3. Define a square 

square' :: Int -> [(Int, Int)]
square' n = grid' n n  

-- 4. make a replicate function 

replicate' :: Int -> a -> [a]
replicate' n m = [m | _ <- [1..n]]

-- 5. Pythagorean Triples
complex_tri :: (Num a, Enum a) => a -> [Complex a]
complex_tri n = [x :+ y | x <- [1..n], y <- [1..x]]

complex_tri_squares :: (Enum a, RealFloat a) => a -> [Complex a]
complex_tri_squares n = [a*a | a <- complex_tri n]

ans5 :: (Enum c, RealFloat c) => c -> [(c, c, c)]
ans5 n = [(realPart a, imagPart a, magnitude a) | a <- (complex_tri_squares n), imagPart a /= 0 && realPart a /= 0]

-- 6. A positive number is considered perfect if it equals the 
-- sum of all it's factors excluding itself. 

factors' :: Int -> [Int]
factors' n = [x | x <- [1..n], mod n x == 0 ] 

perfect' :: Int -> Bool
perfect' n = (-) (sum (factors' n)) n == n

perfects' :: Int -> [Int]
perfects' n = [x | x <- [1..n], perfect' x]

-- 7.
