-- Exersises

-- 1. redefine putStr :: String -> IO () using a list comprehension
-- and the library function sequence_ :: [IO a] -> a

putStr_ :: String -> IO ()
putStr_ xs = sequence_ [ putChar x | x <- xs ++ "\n" ]


-- 2. Using recursion, redefine putBoard s.t. it can display a board
-- of a variable length.

type Board = [Int]

putRow :: Int -> Int -> IO ()
putRow row num = do putStr (show row)
                    putStr ": "
                    putStrLn (concat (replicate num "* "))
                    return ()

putBoard' :: Int -> Board -> IO ()
putBoard' i (x:xs) = do putRow i x
                        if xs == [] then
                           return ()
                        else
                           putBoard' (i+1) xs

putBoard'' :: Board -> IO ()
putBoard'' = putBoard' 0

-- 3. Use the sequence_ function to redefine the above function. 

putBoard :: Board -> IO ()
putBoard b = sequence_ [putRow idx row | (idx, row) <- zip [1..] b]

-- 4. Define an action adder :: IO () that reads a given number 
-- of integers from the keyboard, one per line, and displays thier
-- sum.

adder :: Int -> Int -> IO ()
adder val n = do element <- getLine
                 let integer = read element :: Int
                 if n == 1 then
                    do putStrLn (show (val + integer))
                       return ()
                 else
                    do adder (val+integer) (n-1)

getVal :: IO Int 
getVal = do element <- getLine
            return (read element :: Int)
             
makeList :: Int -> IO [Int]
makeList n = sequence (replicate n getVal)

adder' :: Int -> IO ()
adder' n = do xs <- makeList n
              let total = sum xs
	putStrLn (show total)
return ()

