-- NIM game

import Data.Char

-- For simplicity, we represent each player as integers
next :: Int -> Int
next 1 = 2
next 2 = 1

-- In turn, we represent the board as a list comprising
-- of integers which correspond to the number of remaining
-- stars in each row

type Board = [Int]

initial :: Board
initial = [5,4,3,2,1]

finished :: Board -> Bool
finished = all (==0)

-- A move in the game is considered valid if the given 
-- row has as many stars as we wish to remove.

valid :: Board -> Int -> Int -> Bool
valid board row num = board !! (row - 1) >= num

move :: Board -> Int -> Int -> Board
move board row num = [update r n | (r, n) <- zip [1..] board]
                     where
                        update r n = if r == row then n-num else n 

-- IO Utilities
putRow :: Int -> Int -> IO ()
putRow row num = do putStr (show row)
                    putStr ": "
                    putStrLn (concat (replicate num "* "))
                    return ()

putBoard :: Board -> IO ()
putBoard [a,b,c,d,e] = do putRow 1 a
                          putRow 2 b
                          putRow 3 c
                          putRow 4 d
                          putRow 5 e
                          return ()

getDigit :: String -> IO Int
getDigit prompt = do putStr prompt
                     x <- getChar
                     newline
                     if isDigit x then
                        return (digitToInt x)
                     else
                        do putStrLn "ERROR: Invalid digit"
                           getDigit prompt

newline :: IO ()
newline = putChar '\n'

play :: Board -> Int -> IO ()
play board player =
   do newline
      putBoard board
      if finished board then
         do newline
            putStr "Player "
            putStrLn (show ( next player ) )
            putStrLn " wins!"
      else
         do newline
            putStr "Player "
            putStrLn ( show player )
            row <- getDigit "Enter a row number: "
            num <- getDigit "Stars to remove: "
            if valid board row num then
               play (move board row num) (next player)
            else
               do newline
                  putStrLn "ERROR: Invalid move"
                  play board player

nim :: IO ()
nim = play initial 1
