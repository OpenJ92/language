{- CIS 194 HW 11
   due Monday, 8 April
-}

module SExpr where

import AParser
import Data.Char
import Data.Function
import Control.Applicative

------------------------------------------------------------
--  1. Parsing repetitions
------------------------------------------------------------

zeroOrMore :: Parser a -> Parser [a]
zeroOrMore p = oneOrMore p <|> pure [] 

oneOrMore :: Parser a -> Parser [a]
oneOrMore p = (:) <$> p <*> zeroOrMore p

------------------------------------------------------------
--  2. Utilities
------------------------------------------------------------

spaces :: Parser String
spaces = zeroOrMore (satisfy isSpace)

ident :: Parser String
ident = (:) <$> satisfy isAlpha <*> zeroOrMore (satisfy isAlphaNum)

------------------------------------------------------------
--  3. Parsing S-expressions
------------------------------------------------------------

-- An "identifier" is represented as just a String; however, only
-- those Strings consisting of a letter followed by any number of
-- letters and digits are valid identifiers.
type Ident = String

-- An "atom" is either an integer value or an identifier.
data Atom = N Integer | I Ident
  deriving Show

-- An S-expression is either an atom, or a list of S-expressions.
data SExpr = A Atom
           | Comb [SExpr]
  deriving Show

comb :: Parser SExpr
comb =  A <$> atom
    <|> spaces *> char '(' *> spaces *> (Comb <$> oneOrMore comb) <* spaces <* char ')' <* spaces
 
atom :: Parser Atom
atom =  spaces *> (N <$> posInt) <* spaces
    <|> spaces *> (I <$> ident ) <* spaces

main :: IO [()]
main = sequence $ map (putStrLn . show . runParser comb)  
        [ "5"
        , "foo3"
        , "(((lambda x (lambda y (plus x y))) 3) 5)"
        , "( lots of ( spaces in ) this ( one ) )"
        ]

-- λ: main -- [Expected output]
-- Just (A (N 5),"")
-- Just (A (I "foo3"),"")
-- Just (Comb [Comb [Comb [A (I "lambda"),A (I "x"),Comb [A (I "lambda"),A (I "y"),Comb [A (I "plus"),A (I "x"),A (I "y")]]],A (N 3)],A (N 5)],"")
-- Just (Comb [A (I "lots"),A (I "of"),Comb [A (I "spaces"),A (I "in")],A (I "this"),Comb [A (I "one")]],"")
