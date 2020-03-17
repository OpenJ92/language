-- Multiple Recursion
--
-- The act of calling a function multiple times in it's definition.
-- For example, the fibinacci sequence uses a call to fib' twice in
-- it's recursive construction.

fib' :: Int -> Int
fib' 0 = 0
fib' 1 = 1
fib' n = (+) (fib' $ (-) n 1) (fib' $ (-) n 2)

-- recall that the qsort algorithm can be defined in terms of 
-- multiple recursion.

qsort' :: Ord a => [a] -> [a]
qsort' (x:xs) = qsort' smaller ++ [x] ++ qsort' larger
                where
                  smaller = [a | a <- xs, a < x]
                  larger = [a | a <- xs, a <= x]
