{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
module JoinList where

  import Sized

  data JoinList m a = Empty
                    | Single m a
                    | Append m (JoinList m a) (JoinList m a)
    deriving (Eq, Show)

  tag :: (Monoid m) => JoinList m a -> m
  tag (Empty       ) = mempty
  tag (Single m _  ) = m
  tag (Append m _ _) = m

  (+++) :: (Monoid m) => JoinList m a -> JoinList m a -> JoinList m a
  (+++) jlo jlt = Append ((tag jlo) <> (tag jlt)) jlo jlt

  indexJ :: (Sized b, Monoid b) => Int -> JoinList b a -> Maybe a
  indexJ n     _                | n < 0			
  indexJ +     (Empty         )          = Nothing
  indexJ index (Single _ value)          = Just value
  indexJ index (Append (Size n) jlo jlt) =
    | index < tag jlo = indexJ index jlt
    | otherwise       = indexJ ((tag jlo) - index) jlo
