module Party where
  
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
