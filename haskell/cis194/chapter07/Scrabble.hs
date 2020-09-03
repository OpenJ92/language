{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances #-}
module Scrabble where

  import Data.Char
  import Data.Monoid

  newtype Score = Score Int
    deriving (Eq, Ord, Show, Num)

  score :: Char -> Score
  score = Score . convert . toLower
    where
      convert 'a' = 1
      convert 'b' = 3
      convert 'c' = 3
      convert 'd' = 2
      convert 'e' = 1
      convert 'f' = 4
      convert 'g' = 2
      convert 'h' = 4
      convert 'i' = 1
      convert 'j' = 8
      convert 'k' = 5
      convert 'l' = 1
      convert 'm' = 3
      convert 'n' = 1
      convert 'o' = 1
      convert 'p' = 3
      convert 'q' = 10
      convert 'r' = 1
      convert 's' = 1
      convert 't' = 1
      convert 'u' = 1
      convert 'v' = 4
      convert 'w' = 4
      convert 'x' = 8
      convert 'y' = 4
      convert 'z' = 10
      convert  _  = 0

  scoreString :: String -> Score
  scoreString = foldl (<>) (Score 0) . map (score)
  
  instance Semigroup Score where
    (<>) = (+)
  
  instance Monoid Score where
    mempty  = Score 0
    mappend = (+)
