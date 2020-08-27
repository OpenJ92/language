module ExprT where

data ExprT = Lit Integer
           | Add ExprT ExprT
           | Mul ExprT ExprT
  deriving (Show, Eq)

newtype MinMax = MinMax Integer deriving (Show, Eq)
newtype Mod7 = Mod7 Integer deriving (Show, Eq)

class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr ExprT where
  lit = Lit
  add = Add
  mul = Mul

instance Expr Int where
  lit = fromIntegral 
  add = (+)
  mul = (*)

instance Expr Integer where
  lit = id
  add = (+)
  mul = (*)

instance Expr Bool where
  lit = (>0)
  add = (||)
  mul = (&&)

instance Expr MinMax where
  lit = MinMax . id
  add (MinMax x) (MinMax y) = lit (min x y)
  mul (MinMax x) (MinMax y) = lit (max x y)

instance Expr Mod7 where
  lit = Mod7 . (flip mod 7)
  add (Mod7 x) (Mod7 y) = lit (x + y)
  mul (Mod7 x) (Mod7 y) = lit (x * y)
