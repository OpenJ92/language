import Data.List
import Data.Bits

fib :: Integer -> Integer
fib n 
  | n == 0    = 1
  | n == 1    = 1
  | otherwise = fib (n - 1) + fib (n - 2)

fib1 :: [Integer]
fib1 = map fib [1..]

fibs2 :: [Integer]
fibs2 = unfoldr (\(f0, f1) -> Just (f1, (f1, f0+f1))) (0, 1) 

data Stream a = Element a (Stream a)

instance (Show a) => Show (Stream a) where
  show stream = show (take 200 (streamtolist stream))

streamtolist :: Stream a -> [a]
streamtolist (Element x xs) = x : streamtolist xs

streamRepeat :: a -> Stream a
streamRepeat n = Element n (streamRepeat n)

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Element x elems) 
  = Element (f x) (streamMap f elems)

streamFromSeed :: a -> (a -> a) -> Stream a
streamFromSeed n f = Element n (streamFromSeed (f n) f)

nats :: Stream Integer
nats = streamFromSeed 1 (+1)

interleaveStream :: a -> Stream a -> Stream a
interleaveStream n (Element x elems) 
  = Element n (Element x (interleaveStream n elems))

-- Reference: https://www.geeksforgeeks.org/highest-power-of-two-that-divides-a-given-number/
ruler :: Stream Integer
ruler 
  = streamMap (f) . interleaveStream 0 $ streamFromSeed 2 (+2)
  where
    f n = (.&.) (n) (complement (n - 1))
