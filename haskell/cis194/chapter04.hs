module HOF where
  import Data.List hiding (insert)
  
  -- problem 1
  fun1' :: [Integer] -> Integer
  fun1' = foldr (*) 1 . map (flip (-) 2) . filter even

  -- problem 2 -- I'm not sure if this qualifies
  -- as wholemeal programming. Ask at the next 
  -- FP Study Group.
  fun2' :: Integer -> Integer
  fun2' = sum . sequence_total

  -- There's a difference in ease of comprehension of the
  -- Collatz func if you explictly partition on even or odd.
  sequence_partial :: Integer -> [Integer]
  sequence_partial = takeWhile (even) 
                   . iterate (flip div 2) 
                   . (\n -> if even n then n else 3 * n + 1)

  sequence_total :: Integer -> [Integer]
  sequence_total 1 = [] 
  sequence_total n = partial ++ sequence_total (div (last partial) 2)
   where
     partial = sequence_partial n

  -- problem 3
  data Tree a = Node Int (Tree a) a (Tree a)
              | Leaf
              deriving (Show, Eq)

  measure_tree :: Tree a -> Int
  measure_tree Leaf = 0
  measure_tree (Node _ l _ r) = 1 + measure_tree l + measure_tree r

  balanced :: Tree a -> Bool
  balanced Leaf           = True
  balanced tree@(Node i _ _ _) = measure_tree tree == 2^(i + 1) - 1

  is_populated :: Tree a -> Bool
  is_populated tree@(Node i _ _ _) = i == measure_tree tree

  insert :: a -> Tree a -> Tree a
  insert dat Leaf = Node 0 Leaf dat Leaf
  insert dat (Node i l x r)
    | measure_l > measure_r = (Node i l x (insert dat r))
    | measure_l < measure_r = (Node i (insert dat l) x r)
    | otherwise             = 
       let i' = if balanced l then i+1 else i 
                in (Node i' (insert dat l) x r)
    where
      measure_l = measure_tree l
      measure_r = measure_tree r

  construct_tree :: [a] -> Tree a
  construct_tree = foldr insert Leaf

  -- -- Something like this
  -- balanced_insert :: a -> Tree a -> Tree a
  -- balanced_insert z tree@(Node num l x r) = balance . insert
  
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
