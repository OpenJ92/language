-- Mulitiples of 
p001 n = [x | x <- [1..n], (mod x 3) == 0 || (mod x 5) == 0]
ans = sum (p001 999)

