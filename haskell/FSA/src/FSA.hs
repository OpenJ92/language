module FSA where

import Control.Monad.State.Lazy
import qualified Data.Set as Set

  deriving (Ord, Eq)
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

match :: FSA -> [Char] -> Bool
match fsa sentence =
  case computation fsa sentence of
    Nothing -> False
    Just s  -> validFinal fsa s

validFinal :: FSA -> State' -> Bool
validFinal fsa s = elem s (getFinalState fsa)

transit :: FSA -> Char -> (State') -> Maybe ((), State')
transit fsa char state = 
  case getTransitionFunction fsa char state of
    Nothing -> Nothing
    Just s' -> Just ((), s')

transitStateT' :: FSA -> Char -> StateT State' Maybe ()
transitStateT' fsa char = StateT (transit fsa char)
 
computation :: FSA -> Sentence -> Maybe State'
computation fsa sentence 
  = execStateT (traverse id ((transitStateT' fsa) <$> sentence)) (getInitState fsa)

unionFSA :: FSA -> FSA -> Maybe FSA
unionFSA = error "todo: unionFSA"

-- Now that we can build with containers (Set), we should reconstruct in 
-- that context and move towards building fsas from input RE. 

-- Look to construct a regular eexpression parser that constructs FSA
-- Thereafter, make a CFG parser that builds RE given a grammer.
