module HOF where
  
  -- problem 1
  fun1' :: [Integer] -> Integer
  fun1' = foldr (*) 1 . map (flip (-) 2) . filter even

  -- problem 2 -- I'm not sure if this qualifies
  -- as wholemeal programming. Ask at the next 
  -- FP Study Group.
  fun2' :: Integer -> Integer
  fun2' = sum . map (sum) . sequence_total

  sequence_partial :: Integer -> [Integer]
  sequence_partial = takeWhile (even) 
                   . iterate (flip div 2) 
                   . (\n -> if even n then n else 3 * n + 1)

  sequence_total :: Integer -> [[Integer]]
  sequence_total 1 = [] 
  sequence_total n = partial : sequence_total (div (last partial) 2)
   where
     partial = sequence_partial n

  -- problem 3
  data Tree a = Node Int (Tree a) a (Tree a)
              | Leaf
              deriving (Show, Eq)
  
  balance :: Tree a -> Tree a
  balance = undefined

  insert :: a -> Tree a -> Tree a
  insert = undefined

  -- ?? Something like this?
  balanced_insert :: a -> Tree a -> Tree a
  balanced_insert z tree@(Node num l x r) = balance . insert
  
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
