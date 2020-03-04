function prime_factor(num::Int, factor::Int, factors::Array{Int, 1})::Array{Int, 1}
  if is_prime(num)
    append!(factors, num)
    return factors
  elseif num % factor == 0 && is_prime(factor)
    num = convert(Int, num/factor)
    append!(factors, factor)
    return prime_factor(num, factor, factors)
  else
    factor += 1
    return prime_factor(num, factor, factors)
  end
end

prime_factor(num) = prime_factor(num, 2, [1])

function is_prime(num::Int)::Bool
  if num == 2 return true end 
  if num % 2 == 0 return false end
  for i in range(3, convert(Int, round(sqrt(num))); step=2)
    if num % i == 0 return false end
  end
  return true
end


