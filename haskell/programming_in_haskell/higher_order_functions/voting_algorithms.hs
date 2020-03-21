import Data.List

votes :: [String]
votes = ["Red","Green","Blue","Blue","Blue","Blue","Blue","Red","Green","Green","Red","Blue","Green"]

count :: Eq a => a -> [a] -> Int
count x = length . filter (==x)

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) =  x : filter (/=x) (unique xs)

result :: Ord a => [a] -> [(Int,a)]
result vs = sort [(count v vs, v) | v <- unique vs]

winner :: Ord a => [a] -> a
winner = snd . last . result

--------------------------------------------------

ballots :: [[String]]
ballots = [
            ["Red", "Blue"],
            ["Blue"],
            ["Green", "Red", "Blue"], 
            ["Blue", "Green", "Red"],
            ["Green", "Blue"]
          ]

loser :: Ord a => [a] -> a
loser = snd . head . result

m :: Ord a => a -> [[a]] -> [[a]]
m v = map (filter (/=v))

n :: Eq a => a -> [a] -> [a]
n e = filter (/=e)


winner' xss | length (unique xss) > 1 = winner' $ m (loser $ map head $ n [] xss) $ xss
            | otherwise = head $ unique xss
