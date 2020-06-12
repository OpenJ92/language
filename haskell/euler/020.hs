import           Data.List

ans = sum $ unfoldr (app) $ foldr (*) 1 [1..100]
        where
          app x = if x >= 1
                     then Just (rem x 10, div x 10)
                     else Nothing
