function construct_LCM(α::Array{Int, 1})::Int
	Ω_hash = LCM_hash(α)
	Ω_prime = prime_from_hash(Ω_hash)
	return Ω_prime
end

function prime_from_hash(Ω::Dict{Int,Int})::Int
	prime_product = 1
	for (key, value) = pairs(Ω)
		prime_product *= key^value
	end
	return prime_product
end

function LCM_hash(α::Array{Int, 1})::Dict{Int, Int}
	Ω_hash = Dict{Int, Int}()
	for a = α
		α_factors = prime_factor(a)
		α_hash = frequency_hash(α_factors)
		update_hash(α_hash, Ω_hash)
	end
	return Ω_hash
end

function update_hash(local_hash::Dict{Int, Int}, global_hash::Dict{Int, Int})::Dict{Int, Int}
	for key = keys(local_hash)
		if haskey(global_hash, key) && (global_hash[key] < local_hash[key])
			global_hash[key] = local_hash[key]
		elseif !haskey(global_hash, key)
			global_hash[key] = local_hash[key]
		end
	end
	return global_hash
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

function construct_minimal_int(factors::Array{Int, 1})::Array{Int, 1}
	int_ = 1
	mult = []
	for factor in factors
		factor_prime = prime_factor(factor)
		append!(mult, length(factor_prime))
	end
	return mult
end

function is_prime(num::Int)::Bool
	if num == 2 return true end 
	if num % 2 == 0 return false end
	for i in range(3, convert(Int, round(sqrt(num))); step=2)
		if num % i == 0 return false end
	end
	return true
end

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

answer = construct_LCM([1:20;])
