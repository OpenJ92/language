-- 1.1 functions

-- A function is a mapping that takes one or more arguments and produces
-- a single result. For example, a function triple takes a number x and 
-- and results in the sum of that element three times.

triple x = x + x + x
sqDist x y = x^2 + y^2

-- We may also compose functions! The following example is a demonstration 
-- of such composition -> think Category Theory

trisqDist x y = triple $ sqDist x y
ns n = sum [1..n]

