-- New from Old: 
--
-- Functions can be defined from the composition of other defined function!
-- The following examples demonstrate that possibility.

even' :: Integral a => a -> Bool
even' n = mod n 2 == 0

splitAt' :: Int -> [a] -> ([a],[a])
splitAt' n xs = ( take n xs, drop n xs ) 

recip' :: Fractional a => a -> a
recip' x = 1 / x
