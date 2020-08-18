{- OPTIONS_GHC -Wall -}

module LogAnalysis where
  import Log
  
  -- Part One - Parsing
  
  parseError :: String -> LogMessage
  parseError message = 
    LogMessage (Error ((read sever)::Int)) ((read times)::Int) log
      where
        (sever:times:remain) = words message
        log = unwords remain

  parse' :: MessageType -> String -> LogMessage
  parse' messagetype message = 
    LogMessage messagetype ((read time)::Int) log
      where
        (time:remain) = words message
        log = unwords remain

  parseWarning :: String -> LogMessage
  parseWarning = parse' Warning

  parseInformation :: String -> LogMessage
  parseInformation = parse' Info

  parseMessage :: String -> LogMessage
  parseMessage log@(mt:message) =
    case mt of
      'E' -> parseError message
      'W' -> parseWarning message
      'I' -> parseInformation message
      otherwise -> Unknown log

  parse :: String -> [LogMessage]
  parse filestream =
    map parseMessage messages
      where
        messages = lines filestream
  
  -- Part Two - Tree Traversal
  -- fixed the following, I think. The tree is completely unbalanced, though

  insert :: LogMessage -> MessageTree -> MessageTree
  insert (Unknown _) tree =  tree
  insert (log) (Leaf) = Node (Leaf) (log) (Leaf)
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
