{-# OPTIONS -fwarn-incomplete-patterns -fwarn-tabs -fno-warn-type-defaults #-}

{-# OPTIONS -fdefer-type-errors  #-}

module HW01 where
import Prelude hiding (takeWhile, all, zip, reverse, concat)
import Test.HUnit
import qualified Data.List as List
import qualified Data.Char as Char
import qualified Data.Maybe as Maybe
import qualified Text.Read as Read

import Text.ParserCombinators.Parsec
import Control.Monad

hw01main :: IO ()
hw01main = do
   _ <- runTestTT $ TestList [ testStyle,
                               testLists,
                               testWeather,
                               testSoccer ]
   return ()

--------------------------------------------------------------------------------

testStyle :: Test
testStyle = "testStyle" ~:
   TestList [ tabc , tarithmetic, treverse, tzip ]

abc :: Bool -> Bool -> Bool -> Bool
abc x y z | x && y    = True
          | x && z    = True
          | otherwise = False

tabc :: Test
tabc = "abc" ~: TestList [abc True False True ~?= True,
                          abc True False False ~?= False,
                          abc False True True ~?= False]

arithmetic :: ((Int, Int), Int) -> ((Int,Int), Int) -> (Int, Int, Int)
arithmetic ((a, b), c) ((d, e), f) = ((((((b*f) - (c*e)), ((c* d) - (a*f)), ((a*e)-(b*d))))))
 

tarithmetic :: Test
tarithmetic = "arithmetic" ~:
   TestList[ arithmetic ((1,2),3) ((4,5),6) ~?= (-3,6,-3),
             arithmetic ((3,2),1) ((4,5),6) ~?= (7,-14,7) ]

reverse :: [a] -> [a]
reverse l  = reverse' l []

reverse' :: [a] -> [a] -> [a]
reverse' [ ]      acc = acc 
reverse' [x]      acc = x:acc
reverse' l@(x:xs) acc = reverse' xs (x:acc)
 

treverse :: Test
treverse = "reverse" ~: TestList [reverse [3,2,1] ~?= [1,2,3],
                                  reverse [1]     ~?= [1] ]

zip :: [a] -> [b] -> [(a,b)]
zip [] _ = []
zip _ [] = []
zip (x:xs) (y:ys) = ((,) x y) : zip xs ys

tzip :: Test
tzip = "zip" ~:
  TestList [ zip "abc" [True,False,True] ~?= [('a',True),('b',False), ('c', True)],
             zip "abc" [True] ~?= [('a', True)],
             zip [] [] ~?= ([] :: [(Int,Int)]) ]

--------------------------------------------------------------------------------

testLists :: Test
testLists = "testLists" ~: TestList
  [tintersperse, tinvert, ttranspose, tconcat, tcountSub]

-- The intersperse function takes an element and a list
-- and intersperses that element between the elements of the list.
-- For example,
--    intersperse ',' "abcde" == "a,b,c,d,e"
--
-- intersperse is defined in Data.List, and you can test your solution against
-- that one.

intersperse :: a -> [a] -> [a]
intersperse _ [    ] = []
intersperse _ y'@[x] = y'
intersperse x (y:ys) = y : x : intersperse x ys

tintersperse :: Test
tintersperse = "intersperse" ~: 
  TestList [ HW01.intersperse ',' ['H', 'i'] ~?= List.intersperse ',' ['H', 'i']
           , HW01.intersperse 10 [1..20]  ~?= List.intersperse 10 [1..20] 
           ]
 

-- invert lst returns a list with each pair reversed.
-- for example:
--   invert [("a",1),("a",2)]     returns [(1,"a"),(2,"a")]
--   invert ([] :: [(Int,Char)])  returns []

--   note, you need to add a type annotation to test invert with []
--

invert :: [(a,b)] -> [(b,a)]
invert ((x, y):xys) = (y, x) : invert xys
invert [          ] = []

tinvert :: Test
tinvert = "invert" ~: 
  TestList [ invert [("a",1),("a",2)] ~?= [(1,"a"),(2,"a")]
           , invert ([] :: [(Int, Char)]) ~?= []
           ]
 

-- concat

-- The concatenation of all of the elements of a list of lists
-- for example:
--    concat [[1,2,3],[4,5,6],[7,8,9]] returns [1,2,3,4,5,6,7,8,9]
--
-- NOTE: remember you cannot use any functions from the Prelude or Data.List for
-- this problem, even for use as a helper function.

concat :: [[a]] -> [a]
concat [      ] = []
concat (xs:xss) = xs ++ concat xss

tconcat :: Test
tconcat = "concat" ~:
  TestList [ concat [[1,2,3],[4,5,6],[7,8,9]] ~?= [1,2,3,4,5,6,7,8,9] ]

-- transpose  (WARNING: this one is tricky!)

-- The transpose function transposes the rows and columns of its argument.
-- If the inner lists are not all the same length, then the extra elements
-- are ignored. Note, this is *not* the same behavior as the library version
-- of transpose.

-- for example:
--    transpose [[1,2,3],[4,5,6]] returns [[1,4],[2,5],[3,6]]
--    transpose  [[1,2],[3,4,5]] returns [[1,3],[2,4]]
--    transpose  [[]] returns []
-- transpose is defined in Data.List

transpose :: [[a]] -> [[a]]
transpose xss | Prelude.any (null) xss = []
              | otherwise = [List.head <$> xss] ++ transpose (List.tail <$> xss)

ttranspose :: Test
ttranspose = "transpose" ~: 
  TestList [ transpose [[1,2,3],[4,5,6]] ~?= [[1,4],[2,5],[3,6]]
           , transpose [[1,2],[3,4,5]] ~?= [[1,3],[2,4]] 
           -- , transpose [[]] ~?= []
           ]

-- countSub sub str

-- Return the number of (potentially overlapping) occurrences of substring sub
-- found in the string str.
-- for example:
--      countSub "aa" "aaa" returns 2

countSub :: String -> String -> Int
countSub sub str = length . filter (List.isPrefixOf sub) . List.tails $ str 

tcountSub :: Test
tcountSub = "countSub" ~: 
  TestList [ countSub "aa" "aaa" ~?= 2
           , countSub "abc" "abcababc" ~?= 2
           ]

--------------------------------------------------------------------------------
-- Parsers

data Weather = Weather
  { dy'  :: Int
  , max' :: Int
  , min' :: Int
  , avg' :: Int
  , dep' :: Int
  , hdd' :: Int
  , cdd' :: Int
  , wtr' :: Float
  , snw' :: Float
  , dpth' :: Int
  , avgspd' :: Float
  , mxspd'  :: Int
  , mindir' :: Int
  , min'' :: String
  , psbl' :: String
  , ss'  :: Int
  , wx' :: Maybe Int
  , spd' :: Int
  , dr'' :: Int
  }
     

-- Part One: Hottest Day
-- Lets spend some time looking into finding a way to parse this test file.

weather :: String -> String
weather str = undefined

weatherProgram :: IO ()
weatherProgram = do
  str <- readFile "src/jul17.dat"
  putStrLn (weather str)

readInt :: String -> Maybe Int
readInt = Read.readMaybe

testWeather :: Test
testWeather = "weather" ~: do str <- readFile "src/jul17.dat"
                              weather str @?= "6"

--------

-- Part Two: Soccer League Table

soccer :: String -> String
soccer = error "unimplemented"
 

soccerProgram :: IO ()
soccerProgram = do
  str <- readFile "src/soccer.dat"
  putStrLn (soccer str)

testSoccer :: Test
testSoccer = "soccer" ~: do
  str <- readFile "src/soccer.dat"
  soccer str @?= "Aston_Villa"

-- Part Three: DRY Fusion

weather2 :: String -> String
weather2 = undefined

soccer2 :: String -> String
soccer2 = undefined

-- Kata Questions

-- To what extent did the design decisions you made when writing the original
-- programs make it easier or harder to factor out common code?

shortAnswer1 :: String
shortAnswer1 = "Fill in your answer here"

-- Was the way you wrote the second program influenced by writing the first?

shortAnswer2 :: String
shortAnswer2 = "Fill in your answer here"

-- Is factoring out as much common code as possible always a good thing? Did the
-- readability of the programs suffer because of this requirement? How about the
-- maintainability?

shortAnswer3 :: String
shortAnswer3 = "Fill in your answer here"
