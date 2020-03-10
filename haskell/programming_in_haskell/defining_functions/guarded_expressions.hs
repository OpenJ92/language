-- Guarded Expressions:
--
-- As an alternative to proper conditional expressions, functions
-- can also be defined using guarded expressions in which a sequence
-- of f :: _ -> Bool types. Consider the following definition of 
-- abs'

abs' :: Int -> Int
abs' n | n >= 0 = n
       | otherwise = -n

signum' :: Int -> Int 
signum' n | n > 0 = 1
          | n == 0 = 0
          | otherwise = -1

-- In this context, | should be read as 'such that' 
