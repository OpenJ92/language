-- Recursion on lists
--
-- We may also definne functions on lists. For example, the library
-- function product and length is defined as follows:

product' :: [Int] -> Int
product' [] = 1
product' (n:ns) = n * product' ns

length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length' xs

-- Let us now consider the construction of reverse library function 
-- and concat function via a recursive process. 

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

concat' :: [a] -> [a] -> [a]
concat' [] ys = ys
concat' (x:xs) ys = x : concat' xs ys
