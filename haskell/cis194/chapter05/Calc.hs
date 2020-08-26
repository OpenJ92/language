module Calc where

  import ExprT
  import Parser

  eval :: ExprT -> Integer
  eval (Lit num) = num
  eval (Add exp1 exp2) = (+) (eval exp1) (eval exp2)
  eval (Mul exp1 exp2) = (*) (eval exp1) (eval exp2)

  evalStr :: String -> Maybe Integer
  evalStr = (eval <$>) . parseExp Lit Add Mul
