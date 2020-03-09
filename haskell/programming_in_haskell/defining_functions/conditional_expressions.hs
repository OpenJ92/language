-- Conditional Expressions:
--
-- haskell provides a range of possible constructions for 
-- conditional functions. The following examples demonstrate
-- the syntax for 'conditional expressions'

abs' :: Int -> Int 
abs' n = if n > 0 then n else -n

signum' :: Int -> Int 
signum' n = if n > 0 then 1 else
             if n == 0 then 0 else -1
