-- Abstract Machine

data Expr = Var Int 
          | Add Expr Expr

value' :: Expr -> Int
value' ( Var x ) = x
value' ( Add p q ) = value' p + value' q

