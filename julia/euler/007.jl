function SieveOfErs(𝕌::Int)::Vector{T where T <: Number}
	𝕧 = trues(𝕌); 𝕧[1] = false; 𝕍 = [1:𝕌;]
	for (κ, ϵ) ∈ enumerate(𝕧)
		if ϵ 
			i=2
			while i*κ ≤ 𝕌
				𝕧[i*κ] = false
				i += 1
			end
		end
	end
	return [η for η ∈ 𝕧 .* 𝕍 if η != 0]
end

struct ℂ
	𝕔::Dict{Vector{Function}, Vector{Function}}
end

function 𝔼ℂ(func::Function,α::Any,condition::ℂ,iter::Int)
	for (condition, resolution) ∈ ℂ.𝕔
		if condition(func::Function,α::Any)
			return resolution(func::Function,α::Any)
		end
	end
end

Newton(func::Function, condition::Function) = Newton(func::Function, condition::Function, 1000)
function Newton(func::Function,α::Any,condition::ℂ,iter::Int)
	α₁ = 𝔼ℂ(func::Function,α::Any,condition::ℂ,iter::Int)
	α == α₁ ? return α : return Newton(func::Function,α::Any,condition::ℂ,iter::Int)
end

# Let us consider the Newton algorithm with functions whose rate of
# change is unknown to the user. There exists three operations which one
# must consider upon sampling the domain of our function. First is the 
# simple evaluation of the function. We then act upon the choice of element
# α given the output of the function. Therefore, we'll seek to mutate α. 

# How is this going to work in a disc domain or in domains larger than ℝ¹? 
# What of the case of ℝⁿ
# Note that in general we'll only be able to use this for monotonic functions
# like the one constructed here for problem 007
