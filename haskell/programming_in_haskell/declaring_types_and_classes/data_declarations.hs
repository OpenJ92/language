-- Data Declarations
--
-- A completely new type, as opposed to a renaming of one
-- like described in the previous file, can be declared by
-- specifying it's values using the data mechanism. Consider
-- the following example replicating the boolean type

data Aool = False | True

-- in such a declaration, | is read as or and the values 
-- of this type are called constructors. These values must
-- also be of the form [A-Z].*. Additionally, these constructors
-- must be unique. 
--
-- Consider the following construction of directions:
--

type Pos = (Int, Int)
type Trans = Pos -> Pos
data Move = North | East | South | West deriving (Show)

move :: Move -> Trans 
move North (x, y) = ((+) x 1, y)
move East (x, y) = (x, (+) y 1)
move South (x, y) = ((-) x 1, y)
move West (x, y) = (x, (-) y 1)

moves :: [Move] -> Trans
moves [] p = p
moves (m:ms) p = moves ms (move m p)

rev :: Move -> Move
rev North = South
rev East = West
rev South = North
rev West = East

-- Constructors in a data declaration can also have arguments. 
-- Consider the following data declaration

data Shape = Rect Pos Float Float | Circle Pos Float deriving (Show)

-- That is, the type Shape has constructors Circle r and Rect x y
-- These constructors can then be used to define functions on shapes

area :: Shape -> Float
area (Circle _ r) = pi * r^2
area (Rect _ x y) = x * y

-- NOTE :: The difference between normal functions and constructor
-- functions is that the latter have no defining equations, and exist
-- purely for the purposes of building pieces of data. 
