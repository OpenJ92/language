module Main where

import Lib
import FSA

main :: IO ()
main = someFunc

fsa :: FSA
fsa = FSA alpha init allstates final transition
  where
    alpha = "abcdefghijklmnopqrstuvwxyz"
    init  = State' '_'
    allstates = State' <$> alpha
    final = [State' 'o']
    transition w s =
      let map' 'h' (State' '_') = Just (State' 'h')
          map' 'e' (State' 'h') = Just (State' 'e')
          map' 'l' (State' 'e') = Just (State' 'l')
          map' 'l' (State' 'l') = Just (State' 'l')
          map' 'o' (State' 'l') = Just (State' 'o')
          map' _   _            = Nothing
      in map' w s

fsa' :: FSA
fsa' = FSA alpha init allstates final transition
  where
    alpha = "abcdefghijklmnopqrstuvwxyz"
    init  = State' '_'
    allstates = State' <$> alpha
    final = [State' 'i']
    transition w s =
      let map' 'i' (State' '_') = Just (State' 'i')
          map' 'i' (State' 'i') = Just (State' 'i')
          map' _   _            = Nothing
      in map' w s
