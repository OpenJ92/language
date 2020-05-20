-- Deriving Primitives

-- getLine :: IO String
-- getLine = do x <- getChar
--              if x == '\n' then 
--                  return []
--              else 
--                  do xs <- getLine
--                      return (x:xs)

-- putStr :: String -> IO ()
-- putStr [] = return ()
-- putStr (x:xs) = do putChar x
--                    putStr xs

-- putStrLn :: String -> IO ()
-- putStrLn xs = do putStr xs
--                  putChar '\n'

strlen :: IO ()
strlen = do _ <- putStr "Enter a string: "
            xs <- getLine
            _ <- putStr "The string has "
            _ <- putStr ( show ( length ( xs ) ) )
            _ <- putStr " characters.\n"
            return ()
