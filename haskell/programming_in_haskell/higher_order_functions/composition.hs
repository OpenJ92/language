-- Composition operator
--
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- (.) f g = \x -> f ( g ( x ) ) 

odd' :: Int -> Bool
odd' = not . even

twice' :: (a -> a) -> (a -> a)
twice' f  = f . f

id' = \x -> x

compose [] = id'
compose (f:fs) = f . compose fs

compose' :: [a -> a] -> (a -> a)
compose' = foldr (.) id'
