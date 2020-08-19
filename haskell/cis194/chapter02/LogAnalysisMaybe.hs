{- OPTIONS_GHC -Wall -}

module LogAnalysis where

  import Log
  import Text.Read (readMaybe)

  readTime :: String -> Maybe TimeStamp
  readTime x = readMaybe x

  readSever :: String -> Maybe Int
  readSever x = readMaybe x
  
  -- Part One - Parsing
  
  parseError :: Maybe Int -> Maybe Int -> [String] -> LogMessage
  parseError (Just severity) (Just time) message = 
    LogMessage (Error (severity)) (time) (unwords message)
  parseError (Nothing) (Nothing) message = 
    Unknown (unwords message)

  parse' :: MessageType -> Maybe Int -> [String] -> LogMessage
  parse' messagetype (Just time) message = 
    LogMessage messagetype time (unwords message)
  parse' _ (Nothing) message = 
    Unknown (unwords message)

  parseMessage :: String -> LogMessage
  parseMessage log
    | ("E":rem@(x:y:message)) <- messages = 
      parseError (readSever x) (readTime y) message
    | ("W":x:message) <- messages = 
      parse' Warning (readTime x) message
    | ("I":x:message) <- messages = 
      parse' Info (readTime x) message
    | otherwise = Unknown log
     where
       messages = words log

  parse :: String -> [LogMessage]
  parse filestream =
    map parseMessage messages
      where
        messages = lines filestream
  
  -- Part Two - Tree Traversal
  -- fixed the following, I think. The tree is completely unbalanced, though

  insert :: LogMessage -> MessageTree -> MessageTree
  insert (Unknown _) tree =  tree
  insert log@(LogMessage _ _ _) (Leaf) = Node (Leaf) (log) (Leaf)
  insert log@(LogMessage _ time _) (Node l clog@(LogMessage _ ctime _) r)
    | time <= ctime  = Node (insert log l) clog r
    | otherwise      = Node l clog (insert log r)

  build :: [LogMessage] -> MessageTree
  build = foldr (insert) (Leaf)

  inOrder :: MessageTree -> [LogMessage]
  inOrder (Node l log r) = inOrder l ++ [log] ++ inOrder r
  inOrder (Leaf        ) = []

  whatWentWrong :: [LogMessage] -> [String]
  whatWentWrong [] = []
  whatWentWrong xs =
    let ordered = (inOrder . build) xs
    in whatWentWrong' ordered
    where
      whatWentWrong' [                                           ] = []
      whatWentWrong' ((LogMessage (Error sev) _ message):messages)
        | sev >= 50 = message : whatWentWrong' messages
        | otherwise = whatWentWrong' messages
      whatWentWrong' (_:messages) = whatWentWrong' messages
