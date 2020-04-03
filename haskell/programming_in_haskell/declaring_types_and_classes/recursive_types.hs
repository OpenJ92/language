-- Recursive Types
--
-- New types declared using the data and newtype keywords
-- can also be recursive. As a simple first example, the
-- type of natural numbers from the previous section can 
-- also be declared in a recursive manner:

data Nat = Zero | Succ Nat

-- That is, a value of type Nat is either Zero, or of the 
-- form Succ n for some value n of type Nat. Hence, this 
-- declaration gives rise to an infinte sequence of values,
-- starting with the value Zero, and continuing by applying
-- the constructor function Succ to the previous value in
-- the sequence:

--	Zero
--	Succ Zero
--	Succ ( Succ Zero )
--	Succ ( Succ ( Succ Zero ) )
--	Succ ( Succ ( Succ ( Succ Zero ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) ) ) )
--	Succ ( Succ ( Succ ( Succ ( Succ ( Succ ( Succ ( Succ Zero ) ) ) ) ) ) )

-- In this manner, values of type Nat correspond to natural numbers
-- with Zero representing the number 0, and Succ representing the 
-- successor function (1+). For example, Succ ( Succ ( Succ Zero ) )
-- represents 1 + ( 1 + ( 1 + 0 ) ). More formally, we can define the
-- following conversion functions:

nat2int :: Nat -> Int
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ ( int2nat ( (-) n 1 ) )
