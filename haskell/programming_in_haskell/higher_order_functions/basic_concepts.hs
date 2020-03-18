-- Basic Concepts
--
-- Recall that functions with multiple arguments are usually 
-- defined via the concept of partial application. ie

add' :: Int -> Int -> Int
add' x y = (+) x y

-- is equivilent to:

add'' :: Int -> (Int -> Int)
add'' = \x -> ( \y -> x + y )

-- Additionally, we are able to define functions which contain
-- functions in thier argument set. ie

twice' :: (a -> a) -> a -> a
twice' f x = (f . f) x
