-- Chapter 4 Exercises
--
-- 1. Using library functions, define a funtion halve :: [a] -> ([a],[a])

halve :: [a] -> ([a], [a])
halve xs | mod l 2 == 0 = (take (div l 2) xs , drop (div l 2) xs)
         | otherwise = halve (tail xs)
         where l = length xs

-- 2. Define a function third :: [a] -> a that returns the third element
-- in a list that contains at least this many elements using: 

--	a. head and tail
getElem :: (Num b, Ord b) => b -> [a] -> a
getElem n (x:xs) | n > 0 = getElem (n-1) xs
                 | otherwise = x
third :: [a] -> a
third = getElem 3

--	b. list indexing
getElem' :: Int -> ([a] -> a)
getElem' = \n -> (\xs -> xs !! n)
third' :: [a] -> a
third' = getElem' 3

-- 	c. pattern matching
third''' :: [a] -> a
third''' (x:y:z:zs) = z

-- 3. Consider a function safetail :: [a] -> [a] that's just like tail
-- but it maps the empty list to itself rather than producing an error.
-- Use tail and the function null to to construct the function.

-- 	a. A conditional expression
safetail' :: [a] -> [a]
safetail' xs = if null xs then [] else tail xs

-- 	b. guarded equation
safetail'' :: [a] -> [a]
safetail'' xs | null xs = [] 
              | otherwise = tail xs

--	c. pattern matching
safetail''' :: [a] -> [a]
safetail''' [] = []
safetail''' (x:xs) = xs

-- 4. Show how the disjunction operator || can be defined in four different 
-- ways using pattern matching

or' :: Bool -> Bool -> Bool
or' _ True = True
or' True _ = True
or' _ _ = False

-- 5. Show how to define the following curried function can be formalized
-- via lambda expressions

mult :: Int -> Int -> Int -> Int
mult x y z = x*y*z

mult' :: Int -> (Int -> (Int -> Int))
mult' = \x -> (\y -> (\z -> x*y*z))

-- 6. Luhn Algorithm
-- 	- consider digits as a seperate number
-- 	- moving left, double every number from the second last
-- 	- subtract 9 from each number that is now greater than 9
-- 	- add all of the resulting numbers together
-- 	- if the total is divisible by 10, the number is valid

getDigits :: Int -> [Int]
getDigits 0 = []
getDigits n = getDigits (div n 10) ++ [ mod n 10 ]

dl :: [Int] -> [Int]
dl (x:y:zs) = x : y : map (2*) zs

dl' :: Int -> [Int]
dl' = \x -> reverse $ dl $ reverse $ getDigits x

-- Work on this when you get home
