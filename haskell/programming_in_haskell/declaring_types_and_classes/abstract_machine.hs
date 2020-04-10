-- Abstract Machine

data Expr = Var Int 
          | Add Expr Expr

data Op = EVAL Expr | ADD Int
type Cont = [Op]

e = Add ( Add ( Mult ( Var 2 ) ( Var 2 ) ) ( Var 3 ) ) ( Var 4 )

value' :: Expr -> Int
value' ( Var x ) = x
value' ( Add p q ) = value' p + value' q

eval' :: Expr -> Cont -> Int
eval' ( Var n )   c = exec' c n
eval' ( Add x y ) c = eval' x ( EVAL y : c ) 

exec' :: Cont -> Int -> Int
exec' []             n = n
exec' ( EVAL y : c ) n = eval' y ( ADD n : c )
exec' ( ADD n : c )  m = exec' c (n+m)

value :: Expr -> Int
value e = eval' e []

-- value e
-- eval' Add ( Add ( Var 2 ) ( Var 3 ) ) ( Var 4 ) []
-- eval' ( Add ( Var 2 ) ( Var 3 ) ) [ EVAL ( Var 4 ) ]
-- eval' ( Var 2 ) [ EVAL ( Var 3 ), EVAL ( Var 4 ) ]
-- exec' [ EVAL ( Var 3 ), EVAL ( Var 4 ) ] 2
-- eval' ( Var 3 ) [ ADD 2, EVAL ( Var 4 ) ]
-- exec' [ ADD 2, EVAL ( Var 4 ) ] 3
-- exec' [ EVAL Var 4 ] 5
-- eval' ( Var 4 ) [ ADD 5 ] 
-- exec' [ ADD 5 ] 4
-- exec' [] 9
-- 9
