module Golf where

  import Data.Char

  -- problem 1
  seive :: [a] -> Int -> [a]
  seive xs n = res
    where 
      (_, res) = unzip (filter (\(x,y) -> (mod x n) == 0) (zip [1..] xs))

  skips :: [a] -> [[a]]
  skips xs = zipWith (seive) (replicate (length xs) xs) ([1..])

  -- problem 2
  localMaxima (x:y:z:zs)
    | y > x && y > z = y : localMaxima (y:z:zs)
    | otherwise      = localMaxima (y:z:zs)
  localMaxima _ = []

  -- problem 3
  partition :: (Eq a) => a -> [a] -> ([a], [a])
  partition n xs = (filter (==n) xs, filter (/=n) xs)
  
  construct_histogram' :: (Num a, Eq a) => a -> [a] -> [(a, Int)]
  construct_histogram' _ [] = []
  construct_histogram' x xs = (x, length part) : construct_histogram' (x-1) ition
    where
      (part, ition) = partition x xs

  extrude :: (Ord a, Num a) => [a] -> [[Bool]]
  extrude values  
    | all (0>=) values = []
    | otherwise = skim : extrude next
    where
      skim = map (0>=) values
      next = map (flip (-) 1) values

  histogram' :: (Ord a , Num a) => [a] -> [Char]
  histogram' values = unlines (reverse (footer ++ map (map (convert)) (extrude values)))
    where
      convert True  = ' '
      convert False = '*'
      footer = [map (intToDigit) [1..(length values)], replicate (length values) '=']

  histogram :: (Ord a, Num a) => [a] -> [Char]
  histogram xs = histogram' $ map snd $ construct_histogram' m xs
    where
      m = maximum xs
