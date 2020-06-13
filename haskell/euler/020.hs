import           Data.List

ans :: (Integral a, Foldable t) => t a -> a
ans xs = sum $ unfoldr (app) $ foldr (*) 1 xs
           where
             app x = if x >= 1
                        then Just (rem x 10, div x 10)
                        else Nothing
