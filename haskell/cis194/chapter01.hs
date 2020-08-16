-- Problem Set 1: https://www.seas.upenn.edu/~cis194/spring13/hw/01-intro.pdf

-- qsort
qsort :: (Ord a) => [a] -> [a]
qsort [    ] = []
qsort (x:xs) = (qsort less) ++ [x] ++ (qsort more)
                 where
                   less = filter (<x) xs
                   more = filter (<=x) xs

-- problem 1
toDigits :: Int -> [Int]
toDigits = reverse . getDigits

getDigits :: Int -> [Int]
getDigits n | n > 10 = (mod n 10) : getDigits (div n 10)
            | n >= 0 = [n]
            | otherwise = []

-- problem 2 --> apply to reversed list constructed in getDigits
doubleEveryOther :: [Int] -> [Int]
doubleEveryOther = doubleEveryOther' False

doubleEveryOther' :: Bool -> [Int] -> [Int]
doubleEveryOther' p [    ] = []
doubleEveryOther' p (x:xs) | p = (*) 2 x : doubleEveryOther' (not p) xs
                           | otherwise = x : doubleEveryOther' (not p) xs

-- problem 3
sumDigits :: [Int] -> Int
sumDigits [x] = x
sumDigits (x:xs) = (sumDigits digits) + sumDigits xs
                   where
                     digits = getDigits x

-- problem 4
validate :: Int -> Bool
validate = (==0) . (flip rem 10) . sumDigits . doubleEveryOther . getDigits 
