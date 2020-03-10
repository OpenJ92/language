-- Lambda Functions:
--
-- As an alternative to defining functions using equations, functions
-- can also be constructed using lambda expressions. Consider the 
-- following example:
--
-- 	\x -> x + x
--
-- If we're to do the following in ghci, the result will be 4
--
-- 	(\x -> x + x) 2
--
-- We can also use lambdas to explicitly formalise the meaning 
-- of curried functions:
--
-- 	add :: Int -> (Int -> Int)
-- 	add = \x -> (\y -> x + y) 
--
-- The above expression add takes a number x and returns a function 
-- that takes a number y. A niceity of this form is that the function
-- and the type have the same syntatic form. 

const' :: a -> (b -> a)
const' x = \_ -> x

odds' :: Int -> [Int]
odds' n = map (\x -> (2*) x - 1) [1..n]
