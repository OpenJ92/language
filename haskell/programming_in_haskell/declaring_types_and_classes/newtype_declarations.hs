-- Newtype Declarations
--
-- If a new type has a single constructor with a single 
-- argument, then it can also be declared using the newtype
-- keyword. For example, a type of natural numbers could be
-- declared as follows

newtype Nat = N Int

-- In this case, the single constructor N takes a single argument
-- of type Int, and it is up to the user to ensure that this is 
-- always non-negative. Of course, it is natural to ask how the
-- above declaration using newtype compares to the following 
-- alternatives. 

--		type Nat = Int
--		data Nat = N Int

-- Using newtype rather than type means that Nat and Int are
-- different types rather than synonyms, and hence the type
-- system of Haskell ensures that they cannot accidentally 
-- be mixed up in our programs. 
--
-- Using newtype rather than data brings an efficency benifit
-- because newtype constructors such as N do not incur any 
-- cost when programs are evaluated.
