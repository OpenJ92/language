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
