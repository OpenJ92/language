-- Exercises
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

-- 3. Consider the following type of binary Tree

data T' a = Leaf' a | Node' ( T' a ) ( T' a ) deriving (Show)

t' :: T' Int
t' = Node' (Node' ( Node' ( Node' (Leaf' 5) (Leaf' 6)) ( Leaf' 4 ) ) ( Node' ( Leaf' 6 ) ( Leaf' 9 ) )) (Node' ( Node' ( Leaf' 1 ) ( Leaf' 4 ) ) ( Node' ( Leaf' 6 ) ( Leaf' 9 ) ))

-- Let us say that such a tree is balanced is the number of leaves in 
-- the left and right subtree of every node differs by at most one, with
-- leaves themselves being trivially balanced. Define a function 
-- 	
-- 	balanced :: Tree a -> Bool

count_leaves :: T' a -> Int
count_leaves ( Leaf' n ) = 1
count_leaves ( Node' x y ) = count_leaves x + count_leaves y 

balenced :: T' a -> Bool
balenced (Leaf' _)   = True
balenced (Node' x y) = count_leaves x == count_leaves y

-- 4. Define a function 
-- 	
-- 	balance :: [a] -> T' a
-- 
-- that converts a non-empty list into a balanced tree

balance :: [a] -> T' a
balance [a] = Leaf' a
balance xs = Node' ( balance l ) ( balance r )
             where
               lxsh = div (length xs) 2
               l    = take lxsh xs
               r    = drop lxsh xs

-- 5. Given the type declaration

data Expr = Val Int | Add Expr Expr deriving (Show)

e :: Expr
e = Add ( Add ( Val 2 ) ( Val 3 ) ) ( Val 4 )

-- define a higher-order function 

folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a

-- such that folde f g replaces each Val constructor in an
-- expression by the function f, and each Add consrutctor is
-- replaced by the constructor g.

folde f g ( Val n ) = f n
folde f g ( Add x y ) = g ( folde f g x ) ( folde f g y )

-- 6. Using folde, define a function eval :: Expr -> Int
-- that evaluates an expression to an integer value and
-- a function size :: Expr -> Int that calculates the 
-- number of the values in an expression

size :: Expr -> Int
size = folde (\x -> 1) (\x y -> x + y)
