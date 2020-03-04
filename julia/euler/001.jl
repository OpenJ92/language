function divisible_by(list::StepRange{Int,Int}, factors::Array{Int,1})::Array{Int, 1}
  filtered_list::Array{Int} = []
  for element in list
    for factor in factors
      if element % factor == 0 
        append!(filtered_list, element)
        break
      end
    end
  end
  return filtered_list
end

println("sum(divisible_by(range(0,1000,step=1), [3,5]) = $(sum(divisible_by(range(0,9,step=1), [3,5])))")
