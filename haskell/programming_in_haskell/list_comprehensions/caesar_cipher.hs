-- Caeser Cipher

import Data.Char

letter_to_int :: Char -> Int
letter_to_int c = ord c - ord 'a'

int_to_letter :: Int -> Char
int_to_letter n = chr $ ord 'a' + n

-- sum [(1+) $ letter_to_int c | c <- "math"] == 42 ! 

shift' :: Int -> Char -> Char
shift' n c | isLower c = int_to_letter (mod (letter_to_int c + n) 26)
           | otherwise = c

encode :: Int -> String -> String 
encode n xs = [ shift' n x | x <- xs ]

-- continue when you get home
