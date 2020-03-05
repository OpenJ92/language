-- For reference, the main features of haskell are listed below:
-- -- Consise Programs (chapters 2 and 4)
-- -- Powerful Type System ( chapters 3 and 10 )
-- -- List Comprehensions ( chapter 5 )
-- -- Recursive Functions ( chapter 6 )
-- -- Higher Order Functions ( chapter 7 )
-- -- Monadic Effects ( chapter 8 and 9 ) 
-- -- Lazy Evaluations ( chapter 12 )
-- -- Reasoning about Programs ( chapter 13 )

-- recursive Summation
z :: Num a => [a] -> a 
z [] = 0
z (x : xs) = x + z xs

-- quick-sort
qs :: Ord a => [a] -> [a]
qs [] = []
qs ( x : xs ) = qs smaller ++ [x] ++ qs larger 
                where
                 smaller = [a | a <- xs, a <= x]
                 larger = [b | b <- xs, b > x]

-- Recursive Product
p :: Num a => [a] -> a
p [] = 1
p ( x : xs ) = x * p xs

-- reverse-quick-sort
rqs :: Ord a => [a] -> [a]
rqs [] = []
rqs ( x : xs ) = rqs larger ++ [x] ++ rqs smaller  
                 where
                  smaller = [a | a <- xs, a <= x]
                  larger = [b | b <- xs, b > x]
