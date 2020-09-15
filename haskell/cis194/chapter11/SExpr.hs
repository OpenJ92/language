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
    <|> spaces *> char '(' *> spaces *> 
        (Comb <$> oneOrMore comb) 
        <* spaces <* char ')' <* spaces
 
atom :: Parser Atom
atom =  spaces *> (N <$> posInt) <* spaces
    <|> spaces *> (I <$> ident ) <* spaces

main :: IO ()
main =  putStrLn (show (runParser comb "5"))
     >> putStrLn (show (runParser comb "foo3"))
     >> putStrLn (show (runParser comb "(((lambda x (lambda y (plus x y))) 3) 5)"))
     >> putStrLn (show (runParser comb "( lots of ( spaces in ) this ( one ) )"))
