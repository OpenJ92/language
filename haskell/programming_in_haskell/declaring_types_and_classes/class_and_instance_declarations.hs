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
type Shapes = [Shape]

data Shape = Circle Pos Int | Rectangle Pos Int Int 
             deriving (Show)

class Measure a
  where
    area, perimiter :: a -> Int

class Rigid_Transform a
  where 
    translate :: a -> Pos -> a
    dialate :: a -> Int -> a

instance Measure Shape
  where
    area (Circle _ r) = 3 * r^2
    area (Rectangle _ x y) = x * y 

    perimiter (Circle _ r) = 6 * r
    perimiter (Rectangle _ x y) = 2*x + 2*y

instance Eq Shape
  where
    (==) (Circle c1 r1) (Circle c2 r2) = c1 == c2 && r1 == r2 
    (==) (Rectangle c1 x1 y1) (Rectangle c2 x2 y2) = c1 == c2 && x1 == x2 && y1 == y2 

instance Ord Shape
  where
    (<) (Circle c1 r1) (Circle c2 r2) = r1 < r2
    (<=) (Circle c1 r1) (Circle c2 r2) = r1 <= r2
    max (Circle c1 r1) (Circle c2 r2) | r1 <= r2 = (Circle c2 r2)
                                      | otherwise = (Circle c1 r1)
    min (Circle c1 r1) (Circle c2 r2) | r1 >= r2 = (Circle c2 r2)
                                      | otherwise = (Circle c1 r1)

instance Rigid_Transform Shape
  where
    translate (Circle (x,y) r) (u,v) = (Circle (u+x, v+y) r)
    translate (Rectangle (x,y) i j) (u,v) =  (Rectangle (x+u,y+v) i j)
    dialate (Circle v r) s = (Circle v (s*r))
    dialate (Rectangle (x,y) i j) t = (Rectangle (x,y) (t*i) (t*j))
 
-- -- -- -- -- ---- -- ---- -- ---- -- ---- -- ---- -- 

data Bool' = Fa | Tr
             deriving (Show, Eq, Ord, Read)
