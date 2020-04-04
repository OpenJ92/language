-- Class and Instance declarations
--
-- In Haskell, a new class class can be delared using
-- the class keyword. The following is a reimplementaion
-- of the Eq class defined in the standard prelude.

data Boolean = T | F

not' :: Boolean -> Boolean
not' F = T
not' T = F

class Eq' a 
  where
    eq, neq :: a -> a -> Boolean
    neq x y = not' ( eq x y )

-- This declaration states that for a type to be an instance
-- of the class Eq', it must support the eq and neq. Consider
-- the following

instance Eq' Boolean 
  where 
    eq T T = T
    eq F F = T
    eq T F = F
    eq F T = F

-- -- -- -- -- ---- -- ---- -- ---- -- ---- -- ---- -- 
-- Attempt to use type, data, class and instance to construct 
-- a concept of Shape

type Pos = (Int, Int)
data Shape = Circle Pos Int | Rectangle Pos Int Int deriving (Show)

class Measure a
  where
    area, perimiter :: a -> Int

instance Measure Shape
  where
    area (Circle _ r) = 3 * r^2
    area (Rectangle _ x y) = x * y 

    perimiter (Circle _ r) = 6 * r
    perimiter (Rectangle _ x y) = 2*x + 2*y

-- -- -- -- -- ---- -- ---- -- ---- -- ---- -- ---- -- 
