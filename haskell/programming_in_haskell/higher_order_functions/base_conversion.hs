import Data.Char

bti :: Int -> [Int] -> Int
bti n coef = sum [ w*c | (w, c) <- zip weights coef ] 
                 where 
                   weights = iterate (*n) 1

base_to_int n = foldr (\x y -> x + n*y) 0

-- iterate f x = [x, f x, f . f x, f . f . f x, ...]
-- 	infinite list

int_to_base :: Int -> Int -> [Int]
int_to_base n 0 = []
int_to_base n coef = mod coef n : int_to_base n (div coef n)

make8 :: [Int] -> [Int]
make8 coef = take 8 (coef ++ repeat 0)

-- repeat x = [x, x, x, ...]
-- 	infinite list

encode :: String -> [Int]
encode = concat . map ( make8 . int_to_base 2 . ord ) 

chop8 :: [Int] -> [[Int]]
chop8 [] = []
chop8 base = take 8 base : chop8 (drop 8 base)

decode :: [Int] -> String
decode = map ( chr . base_to_int 2 ) . chop8
