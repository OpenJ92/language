-- The Zip Function:

pairs' :: [a] -> [(a, a)]
pairs' xs = zip xs $ tail xs

sorted' :: Ord a => [a] -> Bool
sorted' xs = and [x <= y | (x, y) <- pairs' xs]

-- Note the lazy evaluation on the infinite list below
positions' :: Eq a => [a] -> a -> [Int] 
positions' xs n = [v | (x, v) <- zip xs [0..], x == n]
