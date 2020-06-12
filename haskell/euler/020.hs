import Data.List

ans = sum $ unfoldr (act) $ foldr (*) 1 [1..100]
        where
          act x = if x >= 1 then Just (rem x 10, div x 10) else Nothing
