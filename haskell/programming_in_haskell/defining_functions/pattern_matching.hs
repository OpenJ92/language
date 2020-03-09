-- Pattern Matching:
--	
-- Consider the following examples:

not' :: Bool -> Bool
not' True = False
not' False = True

-- _ is the wildcard pattern that matches anything. 
and' :: Bool -> Bool -> Bool
and' True True = True
and' _ _ = False

and'' :: Bool -> Bool -> Bool
and'' b c | b == c = True
          | otherwise = False

and''' :: Bool -> Bool -> Bool
and''' True b = b
and''' False _ = False

xor' :: Bool -> Bool -> Bool
xor' b c | b == c = False
         | otherwise = True

-- Tuple Patterns

fst' :: (a, b) -> a
fst' (x, _) = x

scd' :: (a, b) -> b
scd' (_, y) = y

-- List Patterns

testFirst' :: Eq a => a -> [a] -> Bool
testFirst' e' [e , _, _] | e == e' = True
                         | otherwise = False 
