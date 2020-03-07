-- Polymorphic Types:
-- Consider the following example of length

l :: [b] -> Int
l (x:xs) = 1 + l xs
l [] = 0

-- l [1,2,3,4,5] == 5
-- l ['a','b','c','d','e'] == 5 
-- l [True, False, True, False, True] == 5 

t :: Int -> [a] -> [a]
t n [] = []
t 0 xs = []
t n (x:xs) = [x] ++ t (n-1) xs

-- t 2 [1,2,3,4,5] == [1,2]
-- t 2 ['a','b','c','d','e'] == ['a','b']
-- t 2 [True, False, True, False, True] == [True, False]
