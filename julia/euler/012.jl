function ∇_number(n::Int)::Int
	return n*(n+1) / 2
end

function ∇_Sequence(𝕃::Int, 𝕌::Int)::Vector{Int}
	return [∇_number(α) for α ∈ [𝕃:𝕌;]]	
end

function frequency_hash(prime_factor::Array{Int, 1})::Dict{Int, Int}
	freq_dict = Dict{Int, Int}()
	for num = prime_factor
		if haskey(freq_dict, num) == true
			freq_dict[num] += 1
		else
			freq_dict[num] = 1
		end
	end
	return freq_dict
end

function is_prime(num::Int)::Bool
	if num == 2 return true end 
	if num % 2 == 0 return false end
	for i in range(3, convert(Int, round(sqrt(num))); step=2)
		if num % i == 0 return false end
	end
	return true
end

prime_factor(num) = prime_factor(num, 2, [])
function prime_factor(num::Int, factor::Int, factors::Array{Any, 1})::Array{Int, 1}
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

# Write a function to carry this out.
for Τ in ∇_Sequence(1, 20001)
	α = 1
	β = frequency_hash(prime_factor(Τ))
	for (key, value) in β
		α *= (value + 1)
	end
	if α > 500
		println(Τ," ", α, " ", β)
	end
end

