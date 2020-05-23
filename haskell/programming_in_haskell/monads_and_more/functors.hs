-- Functors:

-- All three concepts described in this chapter are a means
-- to abstracting common programming patterns out as definitions
-- We'll start with a review of this idea with the following 
-- functions.

inc :: [Int] -> [Int]
inc [] = []
inc (n:ns) = n+1 : inc ns

sqr :: [Int] -> [Int]
sqr [] = []
sqr (n:ns) = n^2 : sqr ns

-- Notice that both functions are defined in the same manner, 
-- with the empty list being mapped to itself and a non-empty 
-- list to some function applied to the head of the list and 
-- being concatenated to the result of the recursive application
-- of the function to the tail.
--
-- Upon consideration, it's clear that the above two functions may
-- be abstracted out to the following definitions. 

inc' :: [Int] -> [Int]
inc' = map (+1)

sqr' :: [Int] -> [Int]
sqr' = map (^2)

-- More generally, the idea of mapping a function over each element
-- of a data structure isn't specific to the type of lists, but can 
-- be abstracted further to a wide range of parameterised types. The
-- class of types that support such a mapping function are called 
-- functors! In Haskell, this concept is captured in the following
-- definition:
--
-- class Functor f where
--       fmap :: (a -> b) -> [a] -> [b]
--
-- That is, for a parameterised type f to be an instance of the class
-- Functor, it must support a function fmap of the specified type. 
-- The intuition is that fmap takes a function of type a -> b and 
-- a structure of type f a whose elements have a type a and applies
-- a function to each element to give a structure f b.


