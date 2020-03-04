function is_palindrome(num::Int)::Bool
 digits::Array{Int, 1} = get_digits(num); len::Int = length(digits)
  for element::Int = [1:ceil(len/2);]
    if digits[element] != digits[len - element + 1] return false end
  end
  return true
end
function palindrome_products()::Int
  palindromes::Array{Int, 1} = []
  for i::Int = [101:999;]
    for j::Int = [i:999;]
      if is_palindrome(i*j) == true
        push!(palindromes,i*j) 
      end
    end
  end
  return maximum(palindromes)
end
function get_digits(num::Int)::Array{Int, 1}
  digits::Array{Int, 1} = []
  while true
    digit::Int = num % 10; push!(digits, digit);
    num::Int = trunc(Int, num / 10); num < 1 && break;
  end
  return digits
end


