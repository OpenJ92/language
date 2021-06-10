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
g f [    ]  = return []
g f (x:xs)  = f x >>= \x' -> g f xs >>= \xs' -> pure $ (:) x' xs'

h :: Monad m => (a -> b -> m a) -> a -> [b] -> m a
h _ acc [    ] = return acc
h f acc (y:ys) = f acc y >>= \acc' -> h f acc' ys

i' :: Monad m => [m a] -> m [a]
i' [      ] = return []
i' (mx:mxs) = mx >>= \x -> i' mxs >>= \xs -> pure $ (:) x xs

