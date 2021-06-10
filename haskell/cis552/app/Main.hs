module Main where

import Lib
import Test.HUnit
import Text.ParserCombinators.Parsec

-- Lectures
import Lec1
import Lec2
import Lec3
import Lec4

-- Exer
import SecretCode
import DList
import Kata
import Classes
import MonoidFoldable
import QuickCheck
import Persistent

-- Homework
import HW01
import HW02

main :: IO ()
main = getLine >>= putStrLn

g :: Monad m => (a -> m b) -> [a] -> m [b]
g f [    ]  = pure []
g f (x:xs)  = f x >>= \x' -> g f xs >>= \xs' -> pure $ (:) x' xs'

h :: Monad m => (a -> b -> m a) -> a -> [b] -> m a
h _ acc [    ] = pure acc
h f acc (y:ys) = f acc y >>= \acc' -> h f acc' ys

i' :: Monad m => [m a] -> m [a]
i' [      ] = pure []
i' (mx:mxs) = mx >>= \x -> i' mxs >>= \xs -> pure $ (:) x xs

c :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
c amb bmc a = amb a >>= \b -> bmc b

j' :: Monad m => m (m a) -> m a
j' mma = mma >>= id

lM :: Monad m => (a -> b) -> m a -> m b
lM f ma = ma >>= \a -> pure $ f a

lM2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
lM2 f ma mb = ma >>= \a -> mb >>= \b -> pure $ f a b

n :: Monad m => (m (a -> b)) -> m a -> m b
n mab ma = mab >>= \ab -> ma >>= \a -> pure $ ab a

lM' :: Monad m => (a -> b) -> m a -> m b
lM' f ma = pure f `n` ma

lM2' :: Monad m => (a -> b -> c) -> m a -> m b -> m c
lM2' f ma mb = pure f `n` ma `n` mb
