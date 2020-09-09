module Party where
  
  import Data.Tree
  import Employee

  glCons :: Employee -> GuestList -> GuestList
  glCons emp@(Emp _ fun) (GL emps fun') = GL (emp:emps) (fun + fun')
  
  moreFun :: GuestList -> GuestList -> GuestList
  moreFun gl gl' = 
    let comp = compare gl gl'
    in case comp of
         EQ -> gl
         GT -> gl
         LT -> gl'

  nextlevel :: Employee -> [(GuestList, GuestList)] -> (GuestList, GuestList)
  nextlevel emp [ ] = (GL [emp] (empFun emp), mempty::GuestList)
  nextlevel emp gls = (GL [emp] (empFun emp), act gls)
    where
      act = mconcat . map (uncurry moreFun)
