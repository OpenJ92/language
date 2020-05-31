-- State Monad
-- We must consider what exactly is happening in this construction. 
-- What is the logic of this? 

type State = Int
newtype ST a = S (State -> (a, State))

app :: ST a -> State -> (a, State)
app (S st) x = st x

instance Functor ST where
  -- fmap :: (a -> b) -> f a -> f b
  fmap f st = S (\s -> let (x, s') = app st s in (f x, s'))

instance Applicative ST where 
  -- pure :: a -> f a
  pure x = S (\s -> (x, s))

  -- <*> :: f (a -> b) -> f a -> f b
  stf <*> stx = S (
                   \s -> let (f, s')  = app stf s 
                             (x, s'') = app stx s' 
                         in  (f x, s'')
                  )

instance Monad ST where
  -- (>>=) :: m a -> (a -> m b) -> m b
  st >>= f = S (
                \s -> let (x, s') = app st s 
                      in app (f x) s' 
               )

-- Example :: Relabeling Trees

data Tree a = Leaf a
            | Node (Tree a) (Tree a)
            deriving (Show)

tree :: Tree Char
tree = Node (Node (Leaf 'a') (Leaf 'b')) (Leaf 'c')

-- Now consider the problem of defining a function that relabels each leaf
-- in such a tree with a unique 'fresh' integer. This can be implemented 
-- in a pure language by taking the next fresh integer as an argument. 

rlabel :: Tree a -> Int -> (Tree Int, Int)
rlabel (Leaf _) n = (Leaf n, n+1)
rlabel (Node l r) n = rlabel (Node l' r') n''
                        where 
                          (l', n')  = rlabel l n
                          (r', n'') = rlabel r n'

-- We should notice that the above function can be rewritten as Tree a -> ST (Tree Int)

fresh :: ST Int
fresh = S (\n -> (n, n+1))

alabel :: Tree a -> ST (Tree Int)
alabel (Leaf _) = Leaf <$> fresh
alabel (Node l r) = Node <$> alabel l <*> alabel r

-- Using the fact that ST is also a monad, we might write the following;

mlabel :: Tree a -> ST (Tree Int)
mlabel (Leaf _)     = fresh >>= \n -> 
                      return (Leaf n)
mlabel (Node l r )  = mlabel l >>= \l' -> 
                      mlabel r >>= \r' -> 
                      return (Node l' r')
