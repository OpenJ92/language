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

-- 3.
