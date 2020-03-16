-- Basic Concepts:
--
-- We have seen in previous chapters that functions can be defined
-- in terms of other functions. A great example of this is the following
-- definition of the factorial function.

factorial' :: Int -> Int
factorial' n | n > 0 = product [1..n]
             | n == 0 = 1
             | otherwise = 0 

-- In haskell, it is also permissible to define functions in terms of 
-- themselves, as is seen the the recursive reformulation of the above
-- factorial function

factorial'' :: Int -> Int
factorial'' 0 = 1
factorial'' n | n > 0 = n * factorial'' ((-) n 1)
              | otherwise = 0

-- Consider the recursive definition of multiplication

mult' :: Int -> Int -> Int
mult' m 0 = 0
mult' m n = m + (mult' m (n-1))
