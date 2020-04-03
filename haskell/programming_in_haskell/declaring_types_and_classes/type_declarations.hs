-- Type declarations

-- The simplest way to declare a a new type is to introduce a new name
-- for an existing type. Note: types must begin with a Capital letter
--
-- 	type [A-Z].* = .*

type String = [Char]

-- Additionally, types may be declared in a nested fashion which can be
-- seen as follows. 

type Pos = (Int, Int)
type Trans = Pos -> Pos

-- Do note that type declarations cannot be recursive. for example, the
-- following is not a valid type definition.
-- 	
-- 	type Tree = (Int, [Tree])
--
-- Type declarations may also be parameterized, as is that follows

type Pair a = (a, a)
type Dictionary k v = [(k, v)]

-- An example of a function on the above function might be called find

find :: Eq a => a -> Dictionary a b -> b
find x d = head [y | (x', y) <- d, x' == x]
