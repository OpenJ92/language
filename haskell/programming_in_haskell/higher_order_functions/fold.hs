-- foldr
--
-- By in large, functions which recieve a list in their argument 
-- set can be defined using the following pattern.
--
-- 	f [] = v
-- 	f (x:xs) =  # x $ f xs
-- 
-- The library function foldr captures this pattern.

sum' :: Num a => [a] -> a
sum' = foldr (+) 0

product' :: Num a => [a] -> a
product' = foldr (*) 1

or' :: [Bool] -> Bool
or' = foldr (||) False

and' :: [Bool] -> Bool
and' = foldr (&&) True

-- foldr may be defined recursively as follows

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f v [] = v
foldr' f v (x:xs) = f x (foldr' f v xs)

-- Here's a time diagram of the process:
--
-- 	= foldr' (+) 0 [1,2,3,4,5,6]
--	= (+) 1 (foldr' (+) 0 [2,3,4,5,6])
--	= (+) 1 ( (+) 2 (foldr' (+) 0 [3,4,5,6])
--	= (+) 1 ( (+) 2 ( (+) 3 (foldr' (+) 0 [4,5,6])))
--	= (+) 1 ( (+) 2 ( (+) 3 ( (+) 4 (foldr' (+) 0 [5,6]))))
--	= (+) 1 ( (+) 2 ( (+) 3 ( (+) 4 ( (+) 5 (foldr' (+) 0 [6])))))
--	= (+) 1 ( (+) 2 ( (+) 3 ( (+) 4 ( (+) 5 ( (+) 6 (foldr' (+) 0 []))))))
--	= (+) 1 ( (+) 2 ( (+) 3 ( (+) 4 ( (+) 5 ( (+) 6 ( 0 ))))))
--	= (+) 1 ( (+) 2 ( (+) 3 ( (+) 4 ( (+) 5 ( 6 )))))
--	= (+) 1 ( (+) 2 ( (+) 3 ( (+) 4 ( 11 ))))
--	= (+) 1 ( (+) 2 ( (+) 3 ( 15 )))
--	= (+) 1 ( (+) 2 ( 18 ))
--	= (+) 1 ( 20 )
--	= 21

-- The library function foldl captures the following pattern
--
-- 	f v [] = v
-- 	f v (x:xs) = f (# v x) xs
--
-- Which effectively accrues elements into some variable v.

sum' :: Num a => [a] -> a
sum' = foldl (+) 0

product' :: Num a => [a] -> a
product' = foldl (*) 1

or' :: [Bool] -> Bool
or' = foldl (||) False

and' :: [Bool] -> Bool
and' = foldl (&&) True

-- We can define foldl recursively in the following manner

foldl' :: (a -> b -> a) -> a -> [b] -> [a]
foldl' f v [] = v
foldl' f v (x:xs) = foldl' f (f v x) xs

-- Here's the time diagram of the process.
--
-- 	= foldl' (+) 0 [1,2,3,4,5,6]
-- 	= foldl' (+) ((+) 0 1) [2,3,4,5,6]
-- 	= foldl' (+) ((+) ((+) 0 1) 2) [3,4,5,6]
-- 	= foldl' (+) ((+) ((+) ((+) 0 1) 2) 3) [4,5,6]
-- 	= foldl' (+) ((+) ((+) ((+) ((+) 0 1) 2) 3) 4) [5,6]
-- 	= foldl' (+) ((+) ((+) ((+) ((+) ((+) 0 1) 2) 3) 4) 5) [6]
-- 	= foldl' (+) ((+) ((+) ((+) ((+) ((+) ((+) 0 1) 2) 3) 4) 5) 6) []
-- 	= ((+) ((+) ((+) ((+) ((+) (1) 2) 3) 4) 5) 6)
-- 	= ((+) ((+) ((+) ((+) (3) 3) 4) 5) 6)
-- 	= ((+) ((+) ((+) (6) 4) 5) 6)
-- 	= ((+) ((+) (10) 5) 6)
-- 	= ((+) (15) 6)
-- 	= 21

-- The distinction between these functions is not apparent 
-- with function types that are associative. A good example
-- of a function which changes with respect to choice of 
-- folding direction is the length function:

length' :: [z] -> Int
length' = foldr' (\n _ -> 1+n) 0

length'' :: [z] -> Int
length'' = foldl' (\_ n -> n+1) 0
