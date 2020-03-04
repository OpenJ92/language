function sum_digits(α::Number)::Number
	sum(get_digits(α))
end

function get_digits(num::Number)::Vector{Number}
  digits::Vector{Number} = []
  while true
	  digit = rem(num,10); push!(digits, digit)
	  num = div(num,10); num < 1 && break
  end
  return digits
end

function ⊕(α::Vector{Number}, β::Vector{Number})::Vector{Number}
	μ = maximum(length(α), length(β))
	diff = length(α) - length(β)
end

function ⊗(α::Any, β::Any)::Any
	return resolve(coalesce(α' .* β))
end

function coalesce(ζ::Any)::Any
	ranges = Iterators.product([1:ψ for ψ ∈ size(ζ)]...)
	𝕧 = zeros(sum(size(ζ)) - 1)
	for 𝕖 ∈ ranges 𝕧[sum(𝕖)-1] += ζ[𝕖...] end
	return 𝕧
end

function resolve(𝕧::Any)::Any
	r = rem.(𝕧, 10); d = div.(𝕧, 10);
	if all(x -> (x == 0.0), d)
		while 𝕧[end] == 0.0 pop!(𝕧) end; return 𝕧
	else
		rₑ = push!(r, 0); dₑ = pushfirst!(d, 0)
		return resolve(rₑ + dₑ)
	end
end

𝚞 = [get_digits(2^62) for _ in 1:div(1000, 62)] 
𝚐 = [get_digits(2^rem(1000, 62))]
l = append!(𝚞, 𝚐)
a = reduce(⊗, l)
answer = sum(a)
