import Data.Char
import Data.List
import System.IO

-- Basic Declarations

size :: Int
size = 3

data Player = O
            | B 
            | X
            deriving (Eq, Ord, Show)

type Grid = [[Player]]
type Pos = (Int, Int)

next :: Player -> Player
next O = X
next X = O
next B = B

-- Grid Utilities

empty :: Grid
empty = replicate size ( replicate size B )

full :: Grid -> Bool
full = all (/=B) . concat

turn :: Grid -> Player
turn g = if os <= xs then O else X
         where
            os = length ( filter (==O) ps)
            xs = length ( filter (==X) ps)
            ps = concat g

wins :: Player -> Grid -> Bool
wins p g = any line ( rows ++ cols ++ dias )
           where 
             line = all (==p)
             rows = g
             cols = transpose g
             dias = [ diag g, diag ( map reverse g ) ]

diag :: Grid -> [Player]
diag g = [ g !! n !! n | n <- [0..size-1] ]

won :: Grid -> Bool
won g = wins O g || wins X g

-- Display Grid

putGrid :: Grid -> IO ()
putGrid = putStrLn . unlines . concat . interleave bar . map showRow
          where
             bar = [ replicate ((size*4)-1) '-' ]

showRow :: [Player] -> [String]
showRow = beside . interleave bar . map showPlayer
          where
             beside = foldr1 ( zipWith (++) )
             bar = replicate 3 "|"

interleave :: a -> [a] -> [a]
interleave x [ ]    = [ ]
interleave x [y]    = [y]
interleave x (y:ys) =  y : x : interleave x ys

showPlayer :: Player -> [String]
showPlayer O = ["   ", " O ", "   "]
showPlayer B = ["   ", "   ", "   "]
showPlayer X = ["   ", " X ", "   "]

-- Making a move

valid :: Grid -> Int -> Bool
valid g move = 0 <= move && move < size^2 && concat g !! move == B

move :: Grid -> Int -> Player -> [Grid]
move g i p = if valid g i then [chop size (xs ++ [p] ++ ys)] else []
             where (xs, B:ys) = splitAt i (concat g)

chop :: Int -> [a] -> [[a]]
chop n [ ] = [ ]
chop n xs = take n xs : chop n (drop n xs)

-- Reading a number

getNat :: String -> IO Int
getNat prompt = do putStr prompt
                   xs <- getLine
                   if xs /= [] && all isDigit xs then
                      return (read xs)
                   else
                      do putStrLn "ERROR: Invalid number"
                         getNat prompt

-- Human vs. Human

cls :: IO ()
cls = putStr "\ESC[2J"

tictactoe :: IO ()
tictactoe = run empty O

run :: Grid -> Player -> IO ()
run g p = do cls
             goto (1, 1)
             putGrid g
             run' g p

run' :: Grid -> Player -> IO ()
run' g p | wins O g = putStrLn "Player O wins!\n"
         | wins X g = putStrLn "Player X wins!\n"
         | full g   = putStrLn "It's a draw!\n"
         | otherwise = 
             do i <- getNat (prompt p)
                case move g i p of
                   [] -> do putStrLn "ERROR: Invalid move"
                            run' g p
                   [g'] -> run g' (next p)

goto :: Pos -> IO ()
goto (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

prompt :: Player -> String
prompt p = "Player " ++ show p ++ ", enter your move: "

-- Game Trees
