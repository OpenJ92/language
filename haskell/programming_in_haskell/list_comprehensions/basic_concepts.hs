-- Basic Concepts;
--
-- In mathematics, a comprehension is a means to construct one set from 
-- another set. For example, to produce all unique squares, one would 
-- construct the following comprehension

sq :: Int -> [Int]
sq n = [o^2 | o <- [0..n]] 

-- One may read the above comprehension as follows. For o drawn from (<-)
-- the set ([.*]), produce o^2. Generators may also draw from two sets like
-- as what follows

product' :: [a] -> [b] -> [(a, b)]
product' xs ys = [(x, y) | x <- xs, y <- ys]

-- Do note that later generator may depend on those which come before it, 
-- like so.

tri' :: Int -> Int -> [(Int, Int)]
tri' low up = [(x, y) | x <- [low..up], y <- [x..up]]

-- We can make use of the above construction to make a concatonation 
-- function :: [[a]] -> a

concat' :: [[a]] -> [a]
concat' xss = [ x | xs <- xss, x <- xs ]

-- Additionally, the element which draws from may use pattern matching 
-- as is seen in the following example

firsts' :: [(a, b)] -> [a]
firsts' xys = [x | (x, _) <- xys]

-- example length:
length' :: [a] -> Int
length' xs = sum [1 | _ <- xs]
