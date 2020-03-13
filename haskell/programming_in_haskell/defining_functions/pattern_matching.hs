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

and'' :: Bool -> (Bool -> Bool)
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

-- Note: lists are constructed one element at a time via the : 
-- opperator. That is to say, the expression [1, 2, 3] may be
-- expressed as the following atomic expression"
-- 	
-- 	[1, 2, 3] = 1 : ( 2 : ( 3 : [] ) ) 
--
-- With this, and the context of List Patterns from this chapter,
-- we can say that one can carry out the following pattern matchs
-- as follows
--
-- 	x:y:zs [1, 2, 3, 4, 5] => 1 2 [3, 4, 5]
--	x:zs [1, 2, 3, 4, 5] => 1 [2, 3, 4, 5]
--
-- Now we can redefine the above function as follows

testFirst'' :: Eq a => a -> [a] -> Bool
testFirst'' x' (x:xs) | x == x' = True 
                      | otherwise = False
