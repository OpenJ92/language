{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Data.Monoid hiding (Sum, getSum)

-- 1. Define an instance of the Functor class for the following
-- type of binary trees that have data in thier nodes.

import Control.Applicative hiding (ZipList)

data Tree a = Leaf
            | Tree a (Tree a) (Tree a)
            deriving (Show)

instance Functor (Tree) where
  fmap f (Leaf      ) = Leaf
  fmap f (Tree x l r) = Tree (f x) (f <$> l) (f <$> r)

-- 4. 
newtype ZipList a = Z [a] deriving (Show)

instance Functor ZipList where
  fmap g (Z xs) = Z . fmap g $ xs

instance Applicative ZipList where
  pure                   = Z . repeat
  liftA2 f (Z xs) (Z ys) = Z (zipWith f xs ys)
