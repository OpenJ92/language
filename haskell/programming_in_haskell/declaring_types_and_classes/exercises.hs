-- Exersices
--
-- 1. In a similar manner to the function add, define a recursive 
-- multiplication function mult :: Nat -> Nat -> Nat for the recursive
-- type for Natural numbers.

data Nat = Zero | Succ Nat deriving (Show)

add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ ( add m n )

multiply' :: Nat -> Nat -> Nat -> Nat
multiply' k Zero n = k
multiply' k (Succ m) n = multiply' (add k n) m n 

mult :: Nat -> Nat -> Nat
mult = multiply' Zero

-- 2. The standard prelude defines:
-- 	
-- 	data Ordering = LT | EQ | GT
--
-- together with a function
-- 	
-- 	compare :: Ord a => a -> a -> Ordering
--
-- that decides if one value in an ordered type is less than, 
-- equal to or greater than another value. Using this function,
-- redefine the function occurs :: Ord => a -> a -> Tree a -> Bool
-- for search trees.

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show)

t :: Tree Int
t = Node ( Node ( Leaf 1 ) 3 ( Leaf 4 ) ) 5 ( Node ( Leaf 6 ) 7 ( Leaf 9 ) )

occurs' :: Ord a => a -> Tree a -> Bool
occurs' x (Leaf x') = x == x'
occurs' x (Node r x' l) | x == x' = True
                        | x < x' = occurs' x r
                        | otherwise = occurs' x l

