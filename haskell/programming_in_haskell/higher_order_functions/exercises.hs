-- exercises

-- 1. Show how the list comprehension [ f x | x <- xs, p x ] can be
-- re-expressed using the higher order functions map and filter

conditional_map :: (a -> b) -> (a -> Bool) -> [a] -> [b]
conditional_map f p = map f . filter p

-- 2. Define the following higher order functions on lists
a :: [Bool]
a = [True, True, True, True, False]

id' :: a -> a
id' = \x -> x

-- 	a. all
all' :: (a -> Bool) -> [a] -> Bool
all' p xs = null $ filter (not . p) xs

-- 	b. any
any' :: (a -> Bool) -> [a] -> Bool
any' p xs = not . null $ filter p xs

-- 	c. takeWhile
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' p (x:xs) | p x = x : takeWhile' p xs 
                    | otherwise = []

-- 	d. dropWhile
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' p (x:xs) | p x = dropWhile' p xs
                    | otherwise = (x:xs)

-- 3. Redefine the functions map f and filter p using foldr

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr ((:) . f) [] xs
