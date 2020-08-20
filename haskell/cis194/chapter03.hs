module Golf where

  import Data.Char

  seive :: [a] -> Int -> [a]
  seive xs n = res
    where 
      (_, res) = unzip (filter (\(x,y) -> (mod x n) == 0) (zip [1..] xs))

  -- problem 1
  skips :: [a] -> [[a]]
  skips xs = zipWith (seive) (replicate (length xs) xs) ([1..])

  -- problem 2 -- continue tomorrow.
  -- localMaxima (x:y:z:[]) = []
  -- localMaxima (x:y:) = []

  extrude :: (Ord a, Num a) => [a] -> [[Bool]]
  extrude values  
    | all (0>=) values = []
    | otherwise = skim : extrude next
    where
      skim = map (0>=) values
      next = map (flip (-) 1) values

  -- problem 3
  histogram' :: (Ord a , Num a) => [a] -> [Char]
  histogram' values = unlines (reverse (footer ++ map (map (convert)) (extrude values)))
    where
      convert True  = ' '
      convert False = '*'
      footer = [map (intToDigit) numbers, border]
      numbers = [1..(length values)]
      border = replicate (length values) '='
