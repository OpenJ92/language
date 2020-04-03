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
map' :: Foldable t => (a1 -> a2) -> t a1 -> [a2]
map' f = foldr ((:) . f) []

filter' :: Foldable t => (a -> Bool) -> t a -> [a]
filter' p = foldr ( \x xs -> if p x then x:xs else xs ) []

-- 4. Using foldl, define a function dec2int :: [Int] -> Int
-- that converts a decimal number into an integer

dec2int :: [Int] -> Int
dec2int = foldl (\acc x -> 10*acc + x) 0

-- 5. Define the higher order function curry that converts a
-- function on pairs into a curried function and visa-versa

curry' :: ((a, b) -> c) -> a -> b -> c
curry' f = \x y -> f (x,y)

uncurry' ::  (a -> b -> c) -> ((a, b) -> c)
uncurry' f = \(x,y) -> f x y

-- 6. A higher order function unfold that encapsulates a simple 
-- pattern of recursion for producing a list can be defined as 
-- follows:
-- 	
-- 	unfold p h t x | p x = []
-- 		       | otherwise = h x : unfold p h t (t x)
-- 
-- That is, the function unfold p h t produces the empty list
-- if the predicate p is true of the argument value, and other-
-- wise produces a non-empty list by applying the function h
-- to this value to give the head, and the function t to generate
-- another argument that is recursively processed in the same way
-- to produce the tail of the list. 
--
-- 	int2bin = unfold (==0) (`mod` 2) (`div` 2)
--
-- redefine chop8, map f and iterate f using unfold

unfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
unfold p h t x | p x = []
               | otherwise = h x : unfold p h t (t x)

chop8' :: [a] -> [[a]]
chop8' = unfold (null) (take 8) (drop 8)

iterate' :: (a -> a) -> a -> [a]
iterate' f = unfold (\x -> False) (f) (f)

map'' :: (a -> b) -> [a] -> [b]
map'' f = unfold (null) (f.head) (tail)

-- 7. Define a function altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
-- that alternately applies it's two argument functions to sucsessive 
-- elements in a list. 

_altMap :: Bool -> (a -> b) -> (a -> b) -> [a] -> [b]
_altMap _ _ _ [] = []
_altMap b f g (x:xs) | b = f x : _altMap (not b) f g xs
                     | otherwise = g x : _altMap (not b) f g xs

altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap = _altMap True
