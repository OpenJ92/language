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
  deriving (Show)

instance Num Battlefield where
  (-) (Battlefield att def) (Battlefield att' def') = Battlefield (att - att') (def - def')
  (*) _ _         = undefined
  (+) _ _         = undefined
  (fromInteger) _ = undefined
  (signum) _      = undefined
  (abs) _         = undefined


battlefield = Battlefield 20 20

rollDice :: Int -> Rand StdGen [DieValue]
rollDice n = sequence $ replicate n die

policyAttackers :: Battlefield -> Int
policyAttackers battlefield
  | att > 3   = 3
  | att > 0   = att - 1
  | otherwise = 0
  where att = attackers battlefield

policyDefenders :: Battlefield -> Int
policyDefenders battlefield
  | def > 2   = 2
  | def > 0   = def
  | otherwise = 0
  where def = defenders battlefield

roll :: (Battlefield -> Int) -> Battlefield -> Rand StdGen [DieValue]
roll policy = (<$>) (reverse . sort) . rollDice . policy

fight :: Battlefield -> Rand StdGen [Bool]
fight battlefield = zipWith (>) 
                 <$> roll policyAttackers battlefield 
                 <*> roll policyDefenders battlefield

countlosses :: Rand StdGen [Bool] -> Rand StdGen Battlefield
countlosses losses = Battlefield
                  <$> ((length . filter (==True))  <$> losses)
                  <*> ((length . filter (==False)) <$> losses)

battle :: Battlefield -> Rand StdGen Battlefield
battle battlefield = ((-) battlefield) <$> losses
 where
   losses = countlosses $ fight battlefield

invade :: Battlefield -> Rand StdGen Battlefield
invade battlefield = battle battlefield >>= dispatcher

dispatcher :: Battlefield -> Rand StdGen Battlefield
dispatcher battlefield@(Battlefield att def)
  | att <= 2  = pure battlefield
  | def <= 0  = pure battlefield
  | otherwise = invade battlefield
