module StateT where

import Control.Monad.State.Lazy

type VitalForce = Int

data Part 
  = Leg
  | Arm
  | Torso
  | Head
  deriving (Show)

data VitalityPart
  = Live Part
  | Dead Part
  deriving (Show)

data Body = Body VitalityPart VitalityPart VitalityPart VitalityPart
  deriving (Show)

makeBody = Body <$> f' (Dead Arm) <*> f' (Dead Torso) <*> f' (Live Head) <*> f' (Dead Leg)

f :: VitalityPart -> State VitalForce VitalityPart
f part = state $ \vf -> (makeAlive part, updateVitalForce part vf)

f' :: VitalityPart -> StateT VitalForce Maybe VitalityPart
f' part = StateT $ \vf -> 
  if vf > 0 
     then Just (makeAlive part, updateVitalForce part vf) 
     else Nothing

updateVitalForce :: VitalityPart -> (VitalForce -> VitalForce)
updateVitalForce (Live _)     = id
updateVitalForce (Dead Leg)   = \s -> s - 5
updateVitalForce (Dead Arm)   = \s -> s - 4
updateVitalForce (Dead Torso) = \s -> s - 10
updateVitalForce (Dead Head)  = \s -> s - 15

makeAlive :: VitalityPart -> VitalityPart
makeAlive l@(Live _) = l
makeAlive (Dead part) = Live part

func :: (s -> s) -> (a -> b) -> a -> State s b 
func sf f a = state f'
  where
    f' = \s -> (f a, sf s) 

ex :: State Bool Int
ex = pure 1 
  >>= func (\s -> not s) ((+) 10) 
  >>= func (\s -> not s) ((+) 12)
  >>= func (\s -> not s) ((+) 14)

r :: State String Int
r = state $ \s -> (10, s ++ "Run r :: State String Int ,\n")

e :: Int -> State String (Int)
e x = state $ \s -> (x + 1, "Run Function e, \n" <> s)

func' :: State String (Int -> Int -> Int)
func' = state f
  where
    f s = ((+), s <> "Run Add on ")

number' :: Int -> State String Int
number' x = state $ \s -> (x, s <> "Value " <> show x <> " ")

one' :: State String Int
one' = number' 1

ten' :: State String Int
ten' = number' 10

statefulCummulativeSum :: Int -> State String Int
statefulCummulativeSum x = foldl (liftM2 (+)) (number' 0) (take x $ (($) number') <$> [1..])
