-- Tautology Checker

type Assoc a b = [(a, b)]
type Subst = Assoc Char Bool
data Prop = Const Bool
          | Var Char
          | Not Prop
          | And Prop Prop
          | Disj Prop Prop
          | Equiv Prop Prop
          | Imply Prop Prop
          deriving ( Show )

p1 :: Prop; p1 = And ( Var 'A' ) ( Not ( Var 'B' ) )
p2 :: Prop; p2 = Imply ( And ( Var 'A' ) ( Var 'B' ) ) ( Var 'A' )
p3 :: Prop; p3 = Imply ( Var 'A' )  ( And ( Var 'A' ) ( Var 'B' ) )
p4 :: Prop; p4 = Imply ( And ( Var 'A' ) ( Imply ( Var 'A' ) ( Var 'B' ) ) ) ( Var 'B' )
p5 :: Prop; p5 = Disj p4 p1
p6 :: Prop; p6 = Equiv p4 p4

find' :: Char -> Subst -> Bool
find' x ((x',y'):xys) | x == x' = y'
                      | otherwise = find' x xys

rmdups' :: [Char] -> [Char]
rmdups' [] = []
rmdups' (v:vs) | or [ v == v' | v' <- vs ] = rmdups' vs
               | otherwise = v : rmdups' vs

eval' :: Subst -> Prop -> Bool
eval' _ ( Const b ) = b
eval' s ( Var c ) = find' c s
eval' s ( Not p ) = not ( eval' s p )
eval' s ( And p q ) = ( eval' s p ) && ( eval' s q )
eval' s ( Disj p q ) = ( eval' s p ) || ( eval' s q )
eval' s ( Equiv p q ) =  ( eval' s p ) == ( eval' s q )
eval' s ( Imply p q ) = ( eval' s p ) <= ( eval' s q )

vars' :: Prop -> [Char]
vars' ( Const _ ) = []
vars' ( Var a ) = [a]
vars' ( Not p ) = vars' p
vars' ( And p q ) = vars' p ++ vars' q
vars' ( Disj p q ) = vars' p ++ vars' q
vars' ( Equiv p q ) = vars' p ++ vars' q
vars' ( Imply p q ) = vars' p ++ vars' q

bools' :: Int -> [[Bool]]
bools' 0 = [[]]
bools' n = map (False:) bss ++ map (True:) bss
             where
               bss = bools' ((-) n 1)

subst' :: Prop -> [Subst]
subst' p = map (zip vs) (bools' (length vs))
             where
               vs = rmdups' (vars' p)

isTaut :: Prop -> Bool
isTaut p = and [ eval' s p | s <- subst' p ]
