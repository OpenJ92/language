module Party where
  
  import Data.Tree
  import Employee

  glCons :: Employee -> GuestList -> GuestList
  glCons emp@(Emp _ fun) (GL emps fun') = GL (emp:emps) (fun + fun')
  
  moreFun :: GuestList -> GuestList -> GuestList
  moreFun gl gl' = 
    let comp = compare gl gl'
    in case comp of
         EQ -> gl'
         GT -> gl
         LT -> gl'

  nextlevel :: Employee -> [(GuestList, GuestList)] -> (GuestList, GuestList)
  nextlevel emp [ ] = (GL [emp] (empFun emp), mempty::GuestList)
  nextlevel emp gls = (GL [emp] (empFun emp), act gls)
    where
      act = mconcat . map (uncurry moreFun)

  maxFun :: Tree Employee -> GuestList
  maxFun = uncurry max . treeFold nextlevel (mempty::GuestList, mempty::GuestList)

  readTree :: String -> Tree Employee
  readTree = read

  -- main :: IO ()
  -- main = readFile "company.txt" >>= \content   -> 
  --        readTree content       >>= \tree      ->
  --        maxFun tree            >>= \guestlist ->
         
  -- maxFun <$> (readData <$> readFile "company.txt")
