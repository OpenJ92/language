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
