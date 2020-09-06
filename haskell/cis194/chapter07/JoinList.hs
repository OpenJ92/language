{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
module JoinList where

  import Buffer
  import Sized
  import Scrabble


  data JoinList m a = Empty
                    | Single m a
                    | Append m (JoinList m a) (JoinList m a)
    deriving (Eq, Show)

  (!!?) :: [a] -> Int -> Maybe a
  [] !!? _ = Nothing
  _ !!? i | i < 0 = Nothing
  (x:xs) !!? 0 = Just x
  (x:xs) !!? i = xs !!? (i-1)

  jlToList :: JoinList m a -> [a]
  jlToList Empty = []
  jlToList (Single _ a) = [a]
  jlToList (Append _ l1 l2) = jlToList l1 ++ jlToList l2

  tag :: (Monoid m) => JoinList m a -> m
  tag (Empty       ) = mempty
  tag (Single m _  ) = m
  tag (Append m _ _) = m

  (+++) :: (Monoid m) => JoinList m a -> JoinList m a -> JoinList m a
  (+++) jlo jlt = Append ((tag jlo) <> (tag jlt)) jlo jlt

  indexJ :: (Sized b, Monoid b) => Int -> JoinList b a -> Maybe a
  indexJ index (Single _ value)
    | index == 0 = Just value
    | otherwise  = Nothing
  indexJ index (Append m jll jlr)
    | index < 0 || index > collect m = Nothing
    | index < (collect . tag) jll    = indexJ index jll
    | otherwise                      = indexJ (index - (collect . tag) jll) jlr
    where 
      collect = getSize . size 
  indexJ _ _ = Nothing

  dropJ :: (Sized b, Monoid b) => Int -> JoinList b a -> JoinList b a
  dropJ 0 jl = jl
  dropJ n (Append m jll jlr)
    | n >= collect m          = Empty
    | n < (collect . tag) jll = (dropJ n jll) +++ jlr
    | otherwise               = dropJ (n - (collect . tag) jll) jlr
    where 
      collect = getSize . size
  dropJ _ _ = Empty

  takeJ :: (Sized b, Monoid b) => Int -> JoinList b a -> JoinList b a
  takeJ 0 _ = Empty
  takeJ n jl@(Append m jll jlr)
    | n >= collect m           = jl
    | n <  (collect . tag) jll = takeJ n jll
    | n == (collect . tag) jll = jll
    | otherwise                = jll +++ takeJ (n - (collect . tag) jll) jlr
    where
      collect = getSize . size
  takeJ _ jl = jl

  scoreLine :: String -> JoinList (Score, Size) String
  scoreLine cs = 
    let 
      transformed = map (\s -> Single (scoreString s, Size 1) s) . lines $ cs
    in 
      construct_JoinList transformed
    where
      construct_JoinList [ ] = Empty
      construct_JoinList [t] = t
      construct_JoinList css = construct_JoinList left +++ construct_JoinList right
        where
          half  = div (length css) 2
          left  = take half css
          right = drop half css

  instance Buffer (JoinList (Score, Size) String) where
    toString                = unlines . jlToList
    fromString              = scoreLine
    line                    = indexJ
    replaceLine index string joinlist 
      | index < numLines joinlist && index >= 0 
        = 
          let
            newline      = fromString string
            before       = takeJ (index    ) joinlist
            after        = dropJ (index + 1) joinlist
          in
            before +++ newline +++ after
     | otherwise = joinlist
    numLines = getSize  . snd . tag
    value    = getScore . fst . tag
    
