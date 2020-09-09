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
  maxFun = uncurry moreFun . treeFold nextlevel (mempty::GuestList,mempty::GuestList)

  readTree :: String -> Tree Employee
  readTree = read
  
  filterOrphans :: GuestList -> GuestList
  filterOrphans (GL as a') = GL (filter (/=orphan) as) a'

  formatGL :: GuestList -> String
  formatGL (GL as a') 
    = "Total fun: " ++ show a'
      ++ (mconcat . map ((++) "\n" . empName)) as
  
  main :: IO ()
  main =  formatGL 
      <$> filterOrphans
      <$> maxFun 
      <$> readTree 
      <$> readFile "company.txt" 
      >>= putStrLn
