-- Applicatives\

-- Functors abstract the idea of mapping a function over each element of a 
-- structre. Suppose now that we wish to generalise this idea to allow for
-- functions with any number of arguemnts to be mapped, rather than being 
-- restricted to functions of a single arguemnt. Precisely stated, we wish 
-- to define a hierarchy of fmap functions with the following types;
--
-- fmap0 :: a -> f a
-- fmap1 :: (a->b) -> f a -> f b 
-- fmap2 :: (a->b->c) -> f a -> f b -> f c
-- fmap3 :: (a->b->c->d)-> f a -> f b -> f c -> f d
--
-- Note that fmap1 is another name for fmap proper and fmap0 is the degenerate
-- case when the function being mapped has no arguments. One approach would be 
-- to declare a special version of the functor class for each case: Functor0,
-- Functor1, ... , FuctorN. Then, one might write:
--
-- > fmap2 (+) (Just 1) (Just 2) 
-- Just 3
--
-- Using the idea of currying, it turns out that a version of fmap for functions
-- with any desired number of arguments can be constructed in terms of two basic
-- functions with the following types:
--
-- pure :: a -> f a
-- <*> :: f (a -> b) -> f a -> f b
--
-- That is pure converts a value of type a into a structure of type f a, while 
-- <*> if a generalised form of function application for which the argument 
-- function, the argument valuem and the result value are all contained in f
-- structures. As with normal function application, the <*> operator is written 
-- between its two arguments and is assumed to associate left. 
--
-- g <*> x <*> y <*> z == (((g <*> x) <*> y) <*> z)
--
-- A typical use of pure and <*> has the following form:
--
-- pure g <*> x <*> y <*> z <*> ... <a>
--
--
-- Such expressions are said to be applicative style, because of the similarity
-- to mormal functon application notation g x1 x2 x3 ... xn. In both cases, g is a
-- curried function that takes n arguments of type a1 .. an and produces a result
-- of type b. However, in applicative style, each argument xi has type f ai rather
-- than just ai, and the overall result has type f b rather than b. Using this 
-- idea, we can now define the heierarchy of mapping functions:
--
-- fmap :: a -> f a
-- fmap0 = pure
--
-- fmap1 :: (a->b) -> f a -> f b
-- fmap1 g x = pure g <*> x
--
-- fmap2 :: (a->b->c) -> f a -> f b -> f c
-- fmap2 g x y = pure g <*> x <*> y
--
-- fmap3 :: (a->b->c->d) -> f a -> f b -> f c -> f d
-- fmap3 g x y z = pure g <*> x <*> y <*>
-- 
-- The above concept is codified in Haskell as follows
--
-- class Functor f => Applicative f where
--   pure :: a -> f a 
--   <*> :: f (a -> b) -> f a -> f b
--
-- Examples:
--
-- Using the fact that Maybe is a functor and hence supports fmap =, it is
-- straight forward to construct this type into an applicative functor:

import Control.Applicative

data Maybe' a = Just' a
              | Nothing'
              deriving (Show)

instance Functor Maybe' where
  fmap _ Nothing'  = Nothing'
  fmap g (Just' x) = Just' $ g x

instance Applicative Maybe' where
  pure = Just'
  Nothing'  <*> _  = Nothing'
  (Just' g) <*> mx = fmap g mx

-- That is, the function pure trandforms a value into a successful result, while
-- the operator <*> applies a function that may fail to an argument that may fail
-- to produce a reesult that may fail.
--
-- In this manner, the applicative style for Maybe supports a form of exceptional
-- programming in which we can apply pure functions to arguments that may fail
-- without the need to manage the propogation of failiure ourselves, as this is
-- taken care of by the applicative machinery. 

-- Consider another example of an Applicative instance, []
--
-- instance Applicative [] where
--   pure x = [x]
--   gs <*> xs = [g x | g <- gs, x <- xs]
--
-- That is to say the the implementiation of type [] as an Applicative defines
-- pure :: a -> [] a as the singleton list, while <*> takes a list of functions
-- and a list of arguments and applies each function to each argument in turn. 

-- > pure (+1) <*> [1,2,3]
-- [2,3,4]
--
-- > pure (+) <*> [1] <*> [2]
--   -- [(+1)] <*> [2]
--   -- [3] 
-- 
-- > pure (+) <*> [1,2] <*> [3,4]
--  -- [(+1), (+2)] <*> [3,4]
--  -- [(+1) 3,(+1) 4,(+2) 3,(+2) 4]
--  -- [4, 5, 6, 7]

prods :: [Int] -> [Int] -> [Int]
prods xs ys = (*) <$> xs <*> ys

sums :: [Int] -> [Int] -> [Int]
sums xs ys = (+) <$> xs <$> ys

-- In summary, the applicitave style for lists supports a form of non-deterministic 
-- programming in which we can apply pure functions to multi-valued arguments without
-- the need to manage the selection of values or the propogation of failiure.
