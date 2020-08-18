module Golf where

 seive :: [a] -> Int -> [a]
 seive xs n = res
   where 
     (_, res) = unzip (filter (\(x,y) -> (mod x n) == 0) (zip [1..] xs))

 -- problem 1
 skips :: [a] -> [[a]]
 skips xs = zipWith (seive) (replicate (length xs) xs) ([1..])
