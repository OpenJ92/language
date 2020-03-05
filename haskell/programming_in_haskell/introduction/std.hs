-- Upon iniciating `ghci`, haskell's standard library, Prelude.hs, is loaded
-- into the enviornment. Included in that library are your standard arithmetic
-- operators, list functions and many more.
-- ref: https://www.haskell.org/onlinereport/standard-prelude.html

add :: Num a => a -> a -> a 
add x y = (+) x y 

sub :: Num a => a -> a -> a 
sub x y =  (-) x y 

mul :: Num a => a -> a -> a 
mul x y = (*) x y 

lst = [1..100]

-- head lst
-- tail lst
-- take 3 lst
-- drop 3 lst
-- length lst
-- sum lst
-- product lst
-- head lst ++ tail lst
-- reverse lst

-- Show how the library function last can be written as a composition of the
-- above given functions. Show how init can be written.
last xs = head $ reverse xs
takeLast n xs = reverse $ take n $ reverse xs
dropLast n xs = reverse $ drop n $ reverse xs

myInit xs = reverse $ tail $ reverse xs

