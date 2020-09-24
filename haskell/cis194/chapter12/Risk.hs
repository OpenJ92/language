{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Risk where

import Data.List
import Control.Monad.Random

------------------------------------------------------------
-- Die values

newtype DieValue = DV { unDV :: Int } 
  deriving (Eq, Ord, Show, Num)

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Random DieValue where
  random           = first DV . randomR (1,6)
  randomR (low,hi) = first DV . randomR (max 1 (unDV low), min 6 (unDV hi))

die :: Rand StdGen DieValue
die = getRandom

------------------------------------------------------------
-- Risk

type Army = Int

data Battlefield = Battlefield { attackers :: Army, defenders :: Army }
battlefield = Battlefield 10 12

rollDice :: Int -> Rand StdGen [DieValue]
rollDice n = sequence $ replicate n die

rollAttacker :: (Battlefield -> Army) -> Battlefield -> Rand StdGen [DieValue]
rollAttacker role = (<$>) (reverse . sort . drop 1 . take 3) . rollDice . role

battle :: Battlefield -> Rand StdGen Battlefield
battle = undefined
