-- Exercises
--
-- 1. Reconstruct the factorial function s.t. it is
-- guarded against negitive numbers

fac' :: Int -> Int
fac' 0 = 1
fac' x | x > 0 = (*) x $ fac' $ (-) x 1
       | otherwise = 0

-- 2. Define a function sumdown :: Int -> Int that 
-- returns the sum of the non-negative integers from 
-- a given integer down to zero

sumdown :: Int -> Int
sumdown 0 = 0
sumdown x | x >= 0 = (+) x $ sumdown $ (-) x 1
          | otherwise = 0

-- 3. Define exponent recursively

exp' :: Fractional a => Int -> a -> a
exp' 0 _ = 1
exp' n x | n > 0 = x * exp' ((-) n 1) x
         | n < 0 = ((/) 1 x) * exp' ((+) n 1) x

-- 4. Define euclids algorithm recursively.

euclid' :: Int -> Int -> Int
euclid' m n | m > n = euclid' ((-) m n) n
            | m < n = euclid' m ((-) n m) 
            | otherwise = n

-- 5. Show how the following functions are resolved recursively:
-- 	
-- 	a. length [1, 2, 3] = 1 + length [2, 3]
-- 	                    = 1 + 1 + length [3]
-- 	                    = 1 + 1 + 1 + length []
-- 	                    = 1 + 1 + 1 + 0
-- 	                    = 3
--
-- 	b. drop 3 [1,2,3,4,5] = drop 2 [2,3,4,5]
-- 	                      = drop 1 [3,4,5]
-- 	                      = drop 0 [4,5]
-- 	                      = [4,5]
--
-- 	c. init [1,2,3,4,5] = 1 : init [2,3,4,5]
-- 			    = 1 : 2 : init [3,4,5]
-- 			    = 1 : 2 : 3 : init [4,5]
-- 			    = 1 : 2 : 3 : 4 : init [5]
-- 			    = 1 : 2 : 3 : 4 : []
-- 			    = [1,2,3,4]

-- 6. Define the following: 
-- 	a.and' :: [Bool] -> Bool function

and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) | x == True = and' xs
            | otherwise = False

-- 	b. concat' :: [[a]] -> [a]

concat' :: [[a]] -> [a]
concat' [] = []
concat' (xs:xss) = xs ++ concat' xss

--	c. replicate' :: Int -> a -> [a]

replicate' :: Int -> a -> [a]
replicate' 1 m = [m] 
replicate' n m = [m] ++ replicate' ((-) n 1) m

--	d. select :: Int -> [a] -> a

select' :: Int -> [a] -> Maybe a
select' 0 (x:xs) = Just x
select' _ [] = Nothing
select' n (x:xs) = select' ((-) n 1) xs

-- Decide if a value is an element of a list
-- 	e. elem' :: a -> [a] -> Bool

elem' :: Ord a => a -> [a] -> Bool
elem' _ [] = False
elem' x' (x:xs) | x' == x = True
                | otherwise = elem' x' xs

-- 7. Define a merge function which takes two sorted lists and returns a
-- merged ordered list using recusion and comparision only.

merge' :: Ord a => [a] -> [a] -> [a]
merge' [] ys = ys
merge' xs [] = xs
merge' (x:xs) (y:ys) | x <= y = [x] ++ merge' xs (y:ys)
                     | y < x = [y] ++ merge' (x:xs) ys

-- 8. Consrutct merge sort algorithm using merge' and recursion.

msort' :: Ord a => [a] -> [a]
msort' [x] = merge' [x] []
msort' [x, y] = merge' [x] [y]
msort' xs = merge' (msort' up) (msort' lo)
            where 
              mid = div (length xs) 2
              up = take mid xs
              lo = drop mid xs

-- 9. Construct the following functions recursively
--	a. sum' :: [Int] -> Int

sum' :: [Int] -> Int
sum' [x] = x
sum' (x:xs) = x + sum' xs

--	b. take' :: Int -> [a] -> [a]

take' :: Int -> [a] -> [a]
take' 0 (x:xs) = x : []
take' n (x:xs) = x : take ((-) n 1) xs

-- 	c. last' :: [a] -> a

last' :: [a] -> a
last' [x] = x
last' (x:xs) = last' xs
