-- Sequencing

-- In Haskell, a sequence of IO actions can be combined into a
-- single composite action using the do notation whose form is
-- as follows:

-- do v1 <- a1
--    v2 <- a2
--    .
--    .
--    .
--    vn <- an
--    return ( f v1 v2 ... vn )

act :: IO (Char, Char)
act = do x <- getChar
         _ <- getChar
         y <- getChar
         return (x, y)
