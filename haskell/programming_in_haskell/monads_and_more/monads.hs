-- Monads
--
-- The final concept in the chapter is that of the monad. By way of example, 
-- consider the parameterized type Expr

-- data Expr = Val Int
--           | Div Expr Expr
--           deriving (Show)
-- 
-- eval' :: Expr -> Int
-- eval' (Val n) = n
-- eval' (Div n m) = div (eval' n) (eval' m)

-- Unfortunately, this function does not take into account the posibility of 
-- division by zero and will resolve to an exception under the correct conditions. 
-- In order to address this, we should make a safe division function.

safediv' :: Int -> Int -> Maybe Int
safediv' _ 0 = Nothing
safediv' n m = Just (div n m)

data Expr = Val Int
          | Div Expr Expr
          deriving (Show)

-- eval' :: Expr -> Maybe Int
-- eval' (Val n) = Just n
-- eval' (Div n m) = case eval' n of
--                     Nothing -> Nothing
--                     Just n -> case eval' m of
--                                 Nothing -> Nothing
--                                 Just m -> safediv' n m

eval' :: Expr -> Maybe Int
eval' (Val n) = Just n
eval' (Div n m) = eval' n >>= \n -> 
                  eval' m >>= \m -> 
                  safediv' n m

-- In general, a typical expression that is built from the >>= (bind) operation 
-- will follow this structure;
--
-- m1 >>= \x1 ->
-- m2 >>= \x2 ->
-- m3 >>= \x3 ->
-- m4 >>= \x4 ->
-- .
-- .
-- .
-- mn >>= \xn ->
-- f x1 x2 x3 ... xn

-- class Applicative m => Monad m where
--   (>>) :: m a -> (a -> m b) -> m b
--   return :: a -> m a
--
-- Examples:

data Maybe' a = Nothing'
              | Just ' a

instance Monad Maybe' where
  Nothing' >>= f = Nothing'
  (Just' n) >>= f = f n

-- instance Monad [] where
--   xs >>= f = [y | x <- xs, y <- f x]
