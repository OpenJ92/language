{-# OPTIONS -fwarn-incomplete-patterns -fwarn-tabs -fno-warn-type-defaults #-}

-- {-# OPTIONS -fdefer-type-errors  #-}

module HW02 where
import Prelude hiding (takeWhile, all, concat)
import Test.HUnit      -- unit test support

import XMLTypes        -- support file for XML problem (provided)
import Play            -- support file for XML problem (provided)

import Data.Maybe
import Control.Monad.State

doTests :: IO ()
doTests = do
  _ <- runTestTT $ TestList [ testHO, testFoldr, testTree, testFoldTree, testXML ]
  return ()

hw02run :: IO ()
hw02run = do
       doTests
       return ()

testHO :: Test
testHO = TestList [ttakeWhile, tfind, tall, tmap2, tmapMaybe]

-- takeWhile, applied to a predicate p and a list xs,
-- returns the longest prefix (possibly empty) of xs of elements
-- that satisfy p:
-- For example,
--     takeWhile (< 3) [1,2,3,4,1,2,3,4] == [1,2]
--     takeWhile (< 9) [1,2,3] == [1,2,3]
--     takeWhile (< 0) [1,2,3] == []

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile _ [    ] = []
takeWhile p (x:xs) 
  | p x = x : takeWhile p xs
  | otherwise = takeWhile p xs
ttakeWhile :: Test
ttakeWhile = "takeWhile" ~: (assertFailure "testcase for takeWhile" :: Assertion)

-- find pred lst returns the first element of the list that
-- satisfies the predicate. Because no element may do so, the
-- answer is returned in a "Maybe".
-- for example:
--     find odd [0,2,3,4] returns Just 3

find :: (a -> Bool) -> [a] -> Maybe a
find p (x:xs)
  | p x = Just x
  | otherwise = find p xs
find _ [] = Nothing

tfind :: Test
tfind = "find" ~: (assertFailure "testcase for find" :: Assertion)

-- all pred lst returns False if any element of lst
-- fails to satisfy pred and True otherwise.
-- for example:
--    all odd [1,2,3] returns False

all  :: (a -> Bool) -> [a] -> Bool
all p (x:xs)
  | p x = all p xs
  | otherwise = False
all _ [] = True
tall :: Test
tall = "all" ~: (assertFailure "testcase for all" :: Assertion)

-- map2 f xs ys returns the list obtained by applying f to
-- to each pair of corresponding elements of xs and ys. If
-- one list is longer than the other, then the extra elements
-- are ignored.
-- i.e.
--   map2 f [x1, x2, ..., xn] [y1, y2, ..., yn, yn+1]
--        returns [f x1 y1, f x2 y2, ..., f xn yn]
--
-- NOTE: map2 is called zipWith in the Prelude

map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 f xs ys = fmap (uncurry f) $ zip xs ys

tmap2 :: Test
tmap2 = "map2" ~: (assertFailure "testcase for map2" :: Assertion)

-- mapMaybe

-- Map a partial function over all the elements of the list
-- for example:
--    mapMaybe root [0.0, -1.0, 4.0] == [0.0,2.0]

root :: Double -> Maybe Double
root d = if d < 0.0 then Nothing else Just $ sqrt d

mapMaybe :: (a -> Maybe b) -> [a] -> [b]
mapMaybe f = undefined

tmapMaybe :: Test
tmapMaybe = "mapMaybe" ~: (assertFailure "testcase for mapMaybe" :: Assertion)

----------------------------------------------------------------------

testFoldr :: Test
testFoldr = TestList [tinvert, tintersperse, tconcat, tstartsWith, tcountSub]

invert :: [(a,b)] -> [(b,a)]
invert = fmap (\(x, y) -> (y, x))
tinvert :: Test
tinvert = "invert" ~: (assertFailure "testcase for invert" :: Assertion)

intersperse ::  a -> [a] -> [a]
intersperse x = foldl (\acc elem -> elem : if null acc then [] else x : acc) []
tintersperse :: Test 
tintersperse = "intersperse" ~: (assertFailure "testcase for intersperse" :: Assertion)

-- concat

concat :: [[a]] -> [a]
concat = foldr (++) []

tconcat :: Test
tconcat = "concat" ~: (assertFailure "testcase for concat" :: Assertion)

startsWith :: String -> String -> Bool
startsWith xs = evalState $ (foldr (&&) True) <$> (sequence (zsse <$> xs))
tstartsWith = "tstartsWith" ~: (assertFailure "testcase for startsWith" :: Assertion)

zsse :: Char -> Control.Monad.State.State String Bool
zsse c = state $ checkd c

checkd :: (Eq a) => a -> [a] -> (Bool, [a])
checkd _ [    ] = (False, [])
checkd y (x:xs) = (y == x, xs)

para :: (a -> [a] -> b -> b) -> b -> [a] -> b
para _ acc [    ] = acc
para f acc (x:xs) = para f (f x (x:xs) acc) xs

countSub  :: String -> String -> Int
countSub str = para (\_ elems acc -> if startsWith str elems then acc + 1 else acc) 0
tcountSub = "countSub" ~: (assertFailure "testcase for countSub" :: Assertion)



----------------------------------------------------------------------

testTree :: Test
testTree = TestList [ tappendTree, tinvertTree, ttakeWhileTree, tallTree, tmap2Tree,
                      tinfixOrder1, tinfixOrder2 ]

-- | a basic tree data structure
data Tree a = Empty | Branch a (Tree a) (Tree a) deriving (Show, Eq)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f Empty = Empty
mapTree f (Branch x t1 t2) = Branch (f x) (mapTree f t1) (mapTree f t2)

foldTree :: (a -> b -> b -> b) -> b -> Tree a -> b
foldTree _ e Empty     = e
foldTree f e (Branch a n1 n2) = f a (foldTree f e n1) (foldTree f e n2)

-- The appendTree function takes two trees and replaces all of the 'Empty'
-- constructors in the first with the second tree.  For example:
--     appendTree (Branch 'a' Empty Empty) (Branch 'b' Empty Empty) returns
--        Branch 'a' (Branch 'b' Empty Empty) (Branch 'b' Empty Empty)

appendTree :: Tree a -> Tree a -> Tree a
appendTree ta tb = foldTree Branch tb ta
tappendTree :: Test
tappendTree = "appendTree" ~: (assertFailure "testcase for appendTree"  :: Assertion)

-- The invertTree function takes a tree of pairs and returns a new tree
-- with each pair reversed.  For example:
--     invertTree (Branch ("a",1) Empty Empty) returns Branch (1,"a") Empty Empty

invertTree :: Tree (a,b) -> Tree (b,a)
invertTree = mapTree (\(x,y) -> (y,x))
tinvertTree :: Test
tinvertTree = "invertTree" ~: (assertFailure "testcase for invertTree" :: Assertion)

-- takeWhileTree, applied to a predicate p and a tree t,
-- returns the largest prefix tree of t  (possibly empty)
-- where all elements satisfy p.
-- For example, given the following tree

tree1 :: Tree Int
tree1 = Branch 1 (Branch 2 Empty Empty) (Branch 3 Empty Empty)

--     takeWhileTree (< 3) tree1  returns Branch 1 (Branch 2 Empty Empty) Empty
--     takeWhileTree (< 9) tree1  returns tree1
--     takeWhileTree (< 0) tree1  returns Empty

takeWhileTree :: (a -> Bool) -> Tree a -> Tree a
takeWhileTree p = foldTree (\x y z -> if p x then Branch x y z else Empty) Empty
ttakeWhileTree :: Test
ttakeWhileTree = "takeWhileTree" ~: (assertFailure "testcase for takeWhileTree" :: Assertion)

-- allTree pred tree returns False if any element of tree
-- fails to satisfy pred and True otherwise.
-- for example:
--    allTree odd tree1 returns False

allTree :: (a -> Bool) -> Tree a -> Bool
allTree p = foldTree (\x y z -> p x && y && z) True
tallTree :: Test
tallTree = "allTree" ~: (assertFailure "testcase for allTree" :: Assertion)

-- WARNING: This one is a bit tricky!  (Hint: the value
-- *returned* by foldTree can itself be a function.)

-- map2Tree f xs ys returns the tree obtained by applying f to
-- to each pair of corresponding elements of xs and ys. If
-- one branch is longer than the other, then the extra elements
-- are ignored.
-- for example:
--    map2Tree (+) (Branch 1 Empty (Branch 2 Empty Empty)) (Branch 3 Empty Empty)
--        should return (Branch 4 Empty Empty)

map2Tree :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
map2Tree f (Branch x l r) (Branch x' l' r') = Branch (f x x') (map2Tree f l l') (map2Tree f r r')
map2Tree f _ _ = Empty


tmap2Tree :: Test
tmap2Tree = "map2Tree" ~: (assertFailure "testcase for map2Tree" :: Assertion)

----------------------------------------------------------------------

testFoldTree :: Test
testFoldTree = TestList [ tinfixOrder1, tinfixOrder2, trevOrder, tfoldrTree', tfoldlTree' ]

infixOrder :: Tree a -> [a]
infixOrder Empty = []
infixOrder (Branch x l r) = infixOrder l ++ [x] ++ infixOrder r

exTree :: Tree Int
exTree = Branch 5 (Branch 2 (Branch 1 Empty Empty) (Branch 4 Empty Empty))
                  (Branch 9 Empty (Branch 7 Empty Empty))

testInfixOrder = "infixOrder" ~: infixOrder exTree ~?= [1,2,4,5,9,7]

infixOrder1 :: Tree a -> [a]
infixOrder1 = foldTree (\x y z -> y ++ [x] ++ z) []

tinfixOrder1 = "infixOrder2" ~: infixOrder1 exTree ~?= [1,2,4,5,9,7]

foldrTree :: (a -> b -> b) -> b -> Tree a -> b
foldrTree _ e Empty = e
foldrTree f e (Branch k l r) = foldrTree f (f k (foldrTree f e r)) l

infixOrder2 :: Tree a -> [a]
infixOrder2 = foldrTree (:) []

tinfixOrder2 = "infixOrder2" ~: infixOrder2 exTree ~?= [1,2,4,5,9,7]

foldlTree :: (b -> a -> b) -> b -> Tree a -> b
foldlTree _ e Empty = e
foldlTree f e (Branch k l r) = foldlTree f (f (foldlTree f e l) k) r

revOrder :: Tree a -> [a]
revOrder = foldlTree (flip (:)) []
trevOrder = "revOrder" ~: revOrder exTree ~?= [7,9, 5, 4, 2, 1]

-- foldTree :: (a -> b -> b -> b) -> b -> Tree a -> b
-- foldTree _ e Empty     = e
-- foldTree f e (Branch a n1 n2) = f a (foldTree f e n1) (foldTree f e n2)
-- Define primed functions below with respect to foldTree.

-- Incomplete
foldrTree' :: (a -> b -> b) -> b -> Tree a -> b
foldrTree' f e = foldTree (\x l r -> (f x r)) e

-- Incomplete
tfoldrTree' :: Test
tfoldrTree' = TestList ["foldrTree'" ~: foldrTree' (+) 0 tree1 ~?= 6 ]

foldlTree' :: (b -> a -> b) -> b -> Tree a -> b
foldlTree' f e = foldTree (\x l r -> (f l x)) e

tfoldlTree' :: Test
tfoldlTree' = TestList ["foldlTree'" ~: foldlTree (+) 0 tree1 ~?= 6 ]

answer1 :: String
answer1 = undefined

----------------------------------------------------------------------

formatPlay :: SimpleXML -> SimpleXML
formatPlay = mapPlay transformPlay

transformPlay :: String -> String
transformPlay "PLAY"     = "html><body" 
transformPlay "PERSONAE" = "h2"  
transformPlay "PERSONA"  = "b"  
transformPlay "SPEAKER"  = "b"  
transformPlay "TITLE"    = "h1" 
transformPlay "LINE"     = "br" 
transformPlay "ACT"      = "h2" 
transformPlay "SCENE"    = "h3" 
transformPlay "SPEECH"   = "b" 
transformPlay body@(_)   = body

mapPlay :: (String -> String) -> SimpleXML -> SimpleXML
mapPlay f (Element x xs) = Element (f x) $ mapPlay f <$> xs
mapPlay f (PCDATA x)     = PCDATA $ f x

firstDiff :: Eq a => [a] -> [a] -> Maybe ([a],[a])
firstDiff [] [] = Nothing
firstDiff (c:cs) (d:ds)
    | c==d = firstDiff cs ds
    | otherwise = Just (c:cs, d:ds)
firstDiff cs ds = Just (cs,ds)

-- | Test the two files character by character, to determine whether
-- they match.
testResults :: String -> String -> IO ()
testResults file1 file2 = do
  f1 <- readFile file1
  f2 <- readFile file2
  case firstDiff f1 f2 of
    Nothing -> return ()
    Just (cs,ds) -> assertFailure msg where
      msg  = "Results differ: '" ++ take 20 cs ++
            "' vs '" ++ take 20 ds

testXML :: Test
testXML = TestCase $ do
  writeFile "src/dream.html" (xml2string (formatPlay play))
  testResults "src/dream.html" "src/sample.html"

-----------------------------------------------------------------------------

answer2 :: String
answer2 = undefined

