-- Recursive Types
--
-- New types declared using the data and newtype keywords
-- can also be recursive. As a simple first example, the
-- type of natural numbers from the previous section can 
-- also be declared in a recursive manner:

data Nat = Zero | Succ Nat
