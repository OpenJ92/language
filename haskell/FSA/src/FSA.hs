module FSA where

import Control.Monad.State.Lazy

type Sentence = [Char]
type Alphabet = [Char]
type Word'    = Char

type Name     = Char
data State'   = State' Name deriving (Show, Eq)

data FSA = FSA { getAlphabet           :: Alphabet
               , getInitState          ::  State'
               , getStates             :: [State']
               , getFinalState         :: [State']
               , getTransitionFunction :: (Word' -> State' -> Maybe State')
               } 

solve :: Sentence -> FSA -> Maybe Bool
solve sentence fsa = elem <$> (computation' sentence fsa) <*> pure (getFinalState fsa)

compute' :: Word' -> (FSA, Maybe State') -> (Bool, (FSA, Maybe State'))
compute' word (fsa, Nothing) = (False, (fsa, Nothing))
compute' word (fsa, Just s ) = (True , (fsa, updateState))
  where
    updateState = getTransitionFunction fsa word s

compute :: Word' -> State (FSA, Maybe State') Bool
compute word = state (compute' word)

computation' :: Sentence -> FSA -> Maybe (State')
computation' sentence fsa = 
   snd $ execState (traverse id (compute <$> sentence)) (fsa, Just (getInitState fsa)) 
  
-- Look to construct a regular eexpression parser that constructs FSA
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
