{-# LANGUAGE FlexibleInstances #-}

import Data.List
import Data.Bits

fib :: Integer -> Integer
fib n 
  | n == 0    = 1
  | n == 1    = 1
  | otherwise = fib (n - 1) + fib (n - 2)

data Stream a = Element a (Stream a)
data Matrix a = Mat a a a a
  deriving (Show)

instance (Show a) => Show (Stream a) where
  show stream = show . take 2000 $ streamtolist stream

instance Num (Stream Integer) where
  fromInteger n                        = Element n          $ streamRepeat 0
  negate (Element n elems)             = Element (negate n) $ negate elems
  (+) (Element n xs) (Element m ys)    = Element ((+) n m)  $ (+) xs ys
  (*) (Element n xs) st@(Element m ys) = Element ((*) n m)  $ (+) (streamMap (*n) ys) ((*) xs st)

instance Fractional (Stream Integer) where
  (/) stA@(Element n xs) stB@(Element m ys) = Element ((div) n m) $ streamMap ((*) (div 1 m)) (q)
    where
      q = (-) (xs) ((/) ((*) stA ys) (stB))

instance (Num a) => Num (Matrix a) where
  (*) (Mat a b c d) (Mat w x y z) = Mat w11 w12 w21 w22 
    where
      w11 = a*w + b*y
      w12 = a*x + b*z
      w21 = c*w + d*y
      w22 = c*x + d*z

streamtolist :: Stream a -> [a]
streamtolist (Element x xs) = x : streamtolist xs

streamRepeat :: a -> Stream a
streamRepeat n = Element n $ streamRepeat n

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Element x elems) 
  = Element (f x) $ streamMap f elems

streamFromSeed :: a -> (a -> a) -> Stream a
streamFromSeed n f = Element n (streamFromSeed (f n) f)

interleaveStream :: a -> Stream a -> Stream a
interleaveStream n (Element x elems) 
  = Element n . Element x $ interleaveStream n elems

nats :: Stream Integer
nats = streamFromSeed 1 (+1)

ruler :: Stream Integer
ruler 
  = streamMap (f) . interleaveStream 0 $ streamFromSeed 2 (+2)
    where
      f n = (.&.) (n) (complement (n - 1))

x :: Stream Integer
x = Element 0 . Element 1 $ streamRepeat 0

fib1 :: [Integer]
fib1 = map fib [1..]

fibs2 :: [Integer]
fibs2 = unfoldr (\(f0, f1) -> Just (f1, (f1, f0+f1))) (0, 1) 

fibs3 :: Stream Integer
fibs3 = x / (1 - x - x^2)

fibs4 :: Integer -> Integer
fibs4 0 = 0
fibs4 n = let (Mat _ m _ _) = (Mat 1 1 1 0) ^ (n) in m
