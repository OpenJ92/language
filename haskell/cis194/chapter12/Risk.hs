{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Risk where

import Data.List
import Data.Monoid
import Control.Monad
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

battlefield = Battlefield 100 100

rollDice :: Int -> Rand StdGen [DieValue]
rollDice = sequence . flip replicate die

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
fight battlefield 
  =  zipWith 
 <$> pure (>) 
 <*> roll policyAttackers battlefield 
 <*> roll policyDefenders battlefield

countlosses :: [Bool] -> Rand StdGen Battlefield
countlosses battlefield = pure (Battlefield attackWin defendWin)
  where 
    attackWin = (length . filter (==True))  battlefield
    defendWin = (length . filter (==False)) battlefield

-- (>=>) :: (Monad m) => (a -> m b) -> (b -> m c) -> a -> m c 
battle :: Battlefield -> Rand StdGen Battlefield
battle battlefield
  =  (-)
 <$> (pure   battlefield)
 <*> (losses battlefield)
  where
    losses = fight >=> countlosses

invade :: Battlefield -> Rand StdGen Battlefield
-- invade battlefield = pure battlefield >>= battle >>= dispatcher
-- point-free with k-composition.
invade = battle >=> dispatcher

dispatcher :: Battlefield -> Rand StdGen Battlefield
dispatcher battlefield@(Battlefield att def)
  | att <= 2 || def <= 0 = pure   battlefield
  | otherwise            = invade battlefield

step :: Battlefield -> Double
step (Battlefield att def)
  | att >  2   = 0
  | otherwise  = 1

successProb :: Battlefield -> Rand StdGen Double
successProb battlefield 
  =  (/) 
 <$> resolve step      battlefield
 <*> resolve (const 1) battlefield
  where
   resolve f 
     = (<$>) sum 
     . sequence 
     . ((<$>) . (<$>)) (f) 
     . replicate 1000 
     . invade
