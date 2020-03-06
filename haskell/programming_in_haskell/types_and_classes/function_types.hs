-- A function is a mapping from arguments of one type to another and is
-- written as such:
-- 	
-- 	f :: A -> B
-- 	not :: Bool -> Bool
-- 	even :: Int -> Bool
--
-- Prepending function definitions with thier type definitions is a great
-- way to self document your code.

add :: (Int, Int) -> Int 
add (x, y) = x + y

zeroto :: Int -> [Int]
zeroto n = [0..n]

-- Note that there is no restriction on functions in haskell to be total. for
-- example, the result of head [] == undefined.
