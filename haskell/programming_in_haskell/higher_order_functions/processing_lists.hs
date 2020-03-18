-- Processing Lists
--
-- Consider the function map, which applies a given 
-- function to each element in a given list.

map' :: ( a -> b ) -> [a] -> [b]
map' f xs = [ f x | x <- xs ]

map'' :: Eq a => ( a -> b ) -> [a] -> [b]
map'' f (x:xs) | xs /= [] = f x : map'' f xs
               | otherwise = []

-- It should be noted that the polymorphic function f
-- in map may itself be a map. ie
-- 
-- 	= map (map (1+)) [[1, 2], [2, 3]]
--	= [map (1+) [1, 2], map (1+) [2, 3]]
--	= [[2, 3], [3, 4]]

-- Aside:
-- 	Consider the following variable application function
-- 	Why is the type declaration of this form?
g :: (Eq t, Num t) => t -> (b -> b) -> b -> b
g 1 f = f
g n f = f . g ((-) n 1) f

--	Consider the following compose from list function  
-- 	Why is the type declaration of this form?
h :: [b -> b] -> b -> b
h [f] = f
h (f:fs) = f . h fs

-- We'll now consider the filter function, which applies a
-- ( a -> Bool ) type to each element in a list and includes
-- that element if the predicate is True.

filter' :: (a -> Bool) -> [a] -> [a] 
filter' f [] = []
filter' f (x:xs) | f x = x : filter' f xs
                 | otherwise = filter' f xs

-- filter and map are often used together:

sumsqreven :: [Integer] -> Integer
sumsqreven = sum . map' (^2) . filter' even

-- The following are a selection of higher-order functions 
-- defined via recursion. All of their unprimed brethren 
-- can be found in standard prelude.

--	a. all :: (a -> Bool) -> [a] -> Bool 
all' :: (a -> Bool) -> [a] -> Bool 
all' f [] = True
all' f (x:xs) | f x = all' f xs
              | otherwise = False

-- 	b. any :: (a -> Bool) -> [a] -> Bool 
any' :: (a -> Bool) -> [a] -> Bool 
any' f [] = False
any' f (x:xs) | f x = True
              | otherwise = any' f xs

-- 	c. takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' f (x:xs) | f x = x : takeWhile' f xs
                    | otherwise = []

-- 	d. dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' f (x:xs) | f x = dropWhile' f xs
                    | otherwise = (x:xs)
