module HOF where
  
  -- problem 1
  fun1' :: [Integer] -> Integer
  fun1' = foldr (*) 1 . map (flip (-) 2) . filter even

  -- problem 2 -- I'm not sure if this qualifies
  -- as wholemeal programming. Ask at the next 
  -- FP Study Group.
  fun2' :: Integer -> Integer
  fun2' = sum . map (sum) . make_total

  make_partial :: Integer -> [Integer]
  make_partial = takeWhile (even) 
        . iterate (flip div 2) 
        . (\n -> if even n then n else 3 * n + 1)

  make_total :: Integer -> [[Integer]]
  make_total 1 = [] 
  make_total n = partial : make_total (div (last partial) 2)
   where
     partial = make_partial n

  -- problem 3
  
  -- problem 4
  xor :: [Bool] -> Bool
  xor = odd . length . filter (==True)

  -- problem 5
  map' :: (a -> b) -> [a] -> [b]
  map' f = foldr ((:) . f) []

  -- problem 6
  myfoldr :: (a -> b -> a) -> a -> [b] -> a
  myfoldr _ hook [    ] = hook
  myfoldr f hook (b:bs) = f (myfoldr f hook bs) (b)

  myfoldl :: (b -> a -> a) -> a -> [b] -> a
  myfoldl _ hook [    ] = hook
  myfoldl f hook (b:bs) = myfoldl f (f b hook) bs
