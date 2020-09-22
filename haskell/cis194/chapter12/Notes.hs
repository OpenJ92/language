newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Functor Parser where
  -- fmap :: (a -> b) -> Parser a -> Parser b
  fmap f p = Parser (\s -> let mas = runParser p s in first f <$> mas)

instance Applicative Parser where
  -- pure :: a -> Parser a
  pure a = Parser (\s -> Just (a, s))

  -- <*> :: Parser (a -> b) -> Parser a -> Parser b
  (<*>) pf pv = Parser (\s ->
    let mfs = runParser pf s
        mvs = (snd <$> mfs) >>= runParser pv
     in (,)
        <$> ((fst <$> mfs) <*> (fst <$> mvs))
        <*> (snd <$> mvs))

constructParser :: Maybe (a, String) -> (a -> Parser b) -> Maybe (b, String)
constructParser Nothing        _   = Nothing
constructParser (Just (a, s')) apb = runParser (apb a) s'

instance Monad Parser where
  -- return :: a -> Parser a
  return = pure
  -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  (>>=) pa apb = Parser (\s -> constructParser (runParser pa s) apb)
