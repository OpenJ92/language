{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

module Calc where

  import qualified Data.Map as M
  import ExprT
  import VarExprT
  import Parser
  import StackVM


  newtype MinMax = MinMax Integer deriving (Show, Eq)
  newtype Mod7 = Mod7 Integer deriving (Show, Eq)
  
  class Expr a where
    lit :: Integer -> a
    add :: a -> a -> a
    mul :: a -> a -> a
  
  class HasVars a where
    var :: String -> a
  
  instance Expr ExprT where
    lit = ExprT.Lit
    add = ExprT.Add
    mul = ExprT.Mul
  
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

  eval :: ExprT -> Integer
  eval (ExprT.Lit num) = num
  eval (ExprT.Add exp1 exp2) = (+) (eval exp1) (eval exp2)
  eval (ExprT.Mul exp1 exp2) = (*) (eval exp1) (eval exp2)

  evalStr :: String -> Maybe Integer
  evalStr = (eval <$>) . parseExp ExprT.Lit ExprT.Add ExprT.Mul

  testExp :: Expr a => Maybe a
  testExp = parseExp lit add mul "(3 * -4) + 5"

  testInteger = testExp :: Maybe Integer
  testBool = testExp :: Maybe Bool
  testMM = testExp :: Maybe MinMax
  testSat = testExp :: Maybe Mod7

  instance Expr Program where
    -- lit :: Integer -> Program
    -- add :: Program -> Program -> Program
    -- mul :: Program -> Program -> Program
    lit = (flip (:) []) . StackVM.PushI . id 
    add a b =  a ++ b ++ [StackVM.Add]
    mul a b =  a ++ b ++ [StackVM.Mul]

  instance HasVars VarExprT where
    -- var :: String -> VarExprT
    var = VarExprT.Var

  instance Expr VarExprT where
    -- lit :: Integer -> VarExprT
    -- add :: VarExprT -> VarExprT -> VarExprT
    -- mul :: VarExprT -> VarExprT -> VarExprT
    lit = VarExprT.Lit
    add = VarExprT.Add
    mul = VarExprT.Mul

  instance HasVars (M.Map String Integer -> Maybe Integer) where
    -- String -> (M.Map String Integer -> Maybe Integer)
    var = M.lookup

  instance Expr (M.Map String Integer -> Maybe Integer) where
    -- lit :: Integer -> (M.Map String Integer -> Maybe Integer) 
    -- add :: (M.Map String Integer -> Maybe Integer) -> (M.Map String Integer -> Maybe Integer) -> (M.Map String Integer -> Maybe Integer)
    -- mul :: (M.Map String Integer -> Maybe Integer) -> (M.Map String Integer -> Maybe Integer) -> (M.Map String Integer -> Maybe Integer)
    lit x = \_ -> Just x
    add a b = \d -> (+) <$> a d <*> b d
    mul a b = \d -> (*) <$> a d <*> b d

  withVars :: [(String, Integer)] -> (M.Map String Integer -> Maybe Integer) -> Maybe Integer
  withVars vs exp = exp $ M.fromList vs
