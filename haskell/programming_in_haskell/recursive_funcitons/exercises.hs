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
