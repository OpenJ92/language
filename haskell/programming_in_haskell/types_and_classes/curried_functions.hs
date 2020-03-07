-- Consider the following example demonstrating currying or partial 
-- evaluation of a function.

add :: (Int, Int) -> Int 
add (x, y) = x + y

add' :: Int -> ( Int -> Int )
add' x y = x + y

mult :: Int -> ( Int -> ( Int -> Int ) )
mult x y z = x * y * z

cmult :: Int -> ( Int -> Int )
cmult = mult 3

cadd :: Int -> Int 
cadd = add' 3

w :: Int -> [Int]
w a = map add [(a, b) | b <- [1..100]]
