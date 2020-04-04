-- Recursive Types
--
-- New types declared using the data and newtype keywords
-- can also be recursive. As a simple first example, the
-- type of natural numbers from the previous section can 
-- also be declared in a recursive manner:

data Nat = Zero | Succ Nat deriving (Show)

-- That is, a value of type Nat is either Zero, or of the 
-- form Succ n for some value n of type Nat. Hence, this 
-- declaration gives rise to an infinte sequence of values,
-- starting with the value Zero, and continuing by applying
-- the constructor function Succ to the previous value in
-- the sequence:

--	Zero
--	Succ Zero
--	Succ ( Succ Zero )
--	Succ ( Succ ( Succ Zero ) )
--	Succ ( Succ ( Succ ( Succ Zero ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) ) ) ) )

-- In this manner, values of type Nat correspond to natural numbers
-- with Zero representing the number 0, and Succ representing the 
-- successor function (1+). For example, Succ ( Succ ( Succ Zero ) )
-- represents 1 + ( 1 + ( 1 + 0 ) ). More formally, we can define the
-- following conversion functions:

nat2int :: Nat -> Int
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ ( int2nat ( (-) n 1 ) )


-- Addition can be considered a peeling off of Succ from the first
-- argument and pasting it on the second argument. 

add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ ( add m n )

-- How would we extend this to define multiplication, division and 
-- subtraction? 

subtract' :: Nat -> Nat -> Maybe Nat 
subtract' Zero n = Just n
subtract' m Zero = Nothing
subtract' (Succ m) (Succ n) = subtract' (m) (n)

multiply' :: Nat -> Nat -> Nat -> Nat
multiply' k Zero n = k
multiply' k (Succ m) n = multiply' (add k n) m n 

multiply :: Nat -> Nat -> Nat
multiply = multiply' Zero

-- Division, in the way that I'm trying to construct it, will require
-- type class ?? Ord defined on the data.
--
-- 	divide' :: Nat -> Nat -> Nat -> Nat
-- 	divide' k m n = divide' (add k 1) (subtract' m n) n 
--
-- ----------------------------------------
--
-- As another example, the data keyword can be used to declare our
-- own versions of existing built-in types. Consider the construction
-- of a list

data List' a = Nil | Cons a (List' a) deriving (Show)

-- That is, a value of type List' is either Nil, representing the 
-- empty list, or of the form Cons a (List a). Equipped with 
-- this, we might define the function len to calculate the length 
-- of this new form as follows:

len' :: List' a -> Int
len' Nil = 0
len' (Cons _ xs) = 1 + len' xs 

-- Another interesting data structure is the Binary Tree

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show)

t :: Tree Int
t = Node ( Node ( Leaf 1 ) 3 ( Leaf 4 ) ) 5 ( Node ( Leaf 6 ) 7 ( Leaf 9 ) )

occurs :: Eq a => a -> Tree a -> Bool
occurs x (Leaf y) = x == y
occurs x (Node l y r) = x == y || occurs x l || occurs x r 

-- This is a more efficient implementation of occurs, as we do 
-- not need to traverse the entire tree as the other procedure
--
occurs' :: Ord a => a -> Tree a -> Bool
occurs' x (Leaf x') = x == x'
occurs' x (Node r x' l) | x == x' = True
                        | x < x' = occurs' x r
                        | otherwise = occurs' x l

flatten' :: Tree a -> [a]
flatten' (Leaf a) = [a]
flatten' (Node l a r) = flatten' l ++ [a] ++ flatten' r

-- This, of course, is not the only form for a tree. Consider the
-- following distinct forms of a tree

data T a = L a | N ( T a ) ( T a ) deriving (Show)
data T1 a = L1 a | N1 ( T1 a ) a ( T1 a ) deriving (Show)
data T2 a b = L2 a | N2 ( T2 a b ) b ( T2 a b ) deriving (Show)
data T3 a = N3 a [ T3 a ] deriving (Show)
