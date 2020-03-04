include("DataStructure/Graph/node.jl")
include("DataStructure/Graph/graph.jl")

function Collatz(α::Int)::Int
	if α % 2 == 0 return α / 2 else return 3*α + 1 end
end

function ℂ₀_𝔾(α::Int, ℕ::node, 𝔾::graph)::Tuple{Int, node, graph}
	if α ∉ ℕ.data append!(ℕ.data, α) end
	return α, ℕ, 𝔾
end

function ℂ₁_𝔾(α::Int, ℕ::node, 𝔾::graph)::Tuple{Int, node, graph}
	append!(ℕ.data, α); α = Collatz(α);
	return α, ℕ, 𝔾
end

function ℂ₂_𝔾(α::Int, ℕ::node, 𝔾::graph)::Tuple{Int, node, graph}
	ℕ₀ = Node(α); add_node(𝔾, ℕ₀);
	add_parent(ℕ₀,ℕ); add_child(ℕ,ℕ₀);
	α, ℕ₀, 𝔾 = ℂ₁_𝔾(α, ℕ₀, 𝔾)
	return α, ℕ₀, 𝔾
end

function ℂ₃_𝔾(α::Int, ℕ::node, 𝔾::graph)::Tuple{Int, node, graph}
	ℕᵢ = 𝔾.nodes[α]; 
	(ℕᵢ.data[end] != 1) ? α = Collatz(ℕᵢ.data[end]) : α = ℕᵢ.data[end]
	return α, ℕᵢ, 𝔾
end

𝔾_Collatz(α::Int) = 𝔾_Collatz(α, Node(α), Graph())
𝔾_Collatz(α::Int, 𝔾::graph) = 𝔾_Collatz(α, Node(α), 𝔾)
function 𝔾_Collatz(α::Int, ℕ::node, 𝔾::graph)::graph
	if α == 1
		α, ℕ, 𝔾 = ℂ₀_𝔾(α, ℕ, 𝔾); return 𝔾;
	elseif α % 2 == 0
		α, ℕ, 𝔾 = ℂ₁_𝔾(α, ℕ, 𝔾); return 𝔾_Collatz(α, ℕ, 𝔾);
	elseif !haskey(𝔾.nodes, α) && (α % 2 != 0)
		α, ℕ, 𝔾 = ℂ₂_𝔾(α, ℕ, 𝔾); return 𝔾_Collatz(α, ℕ, 𝔾);
	elseif haskey(𝔾.nodes, α) && (α % 2 != 0)
		α, ℕ, 𝔾 = ℂ₃_𝔾(α, ℕ, 𝔾); return 𝔾_Collatz(α, ℕ, 𝔾);
	end
end

function ℂ₁gCP(α::Int, 𝔾::graph, σ::Array{Any, 1})::Tuple{Int, graph, Array{Any, 1}}
	ν = 𝔾.nodes[α]; append!(σ, ν.data); 
	α = (ν.data[end] != 1) ? Collatz(ν.data[end]) : 1
	return α, 𝔾, σ
end

function ℂ₂gCP(α::Int, 𝔾::graph, σ::Array{Any, 1})::Tuple{Int, graph, Array{Any, 1}}
	𝔾 = 𝔾_Collatz(α, 𝔾)
	return α, 𝔾, σ
end

function ℂ₃gCP(α::Int, 𝔾::graph, σ::Array{Any, 1})::Tuple{Int, graph, Array{Any, 1}}
	append!(σ, α); α = Collatz(α);	
	return α, 𝔾, σ
end

get_Collatz_Path(α) = get_Collatz_Path(α, Graph(), [])
get_Collatz_Path(α, 𝔾) = get_Collatz_Path(α, 𝔾, [])
function get_Collatz_Path(α::Int, 𝔾::graph, σ::Array{Any, 1})::Tuple{Int, graph, Array{Any, 1}}
	if (α == 1)
		return α, 𝔾, σ
	elseif (α % 2 == 0)
		return get_Collatz_Path(ℂ₃gCP(α, 𝔾, σ)...)
	elseif haskey(𝔾.nodes, α)
		return get_Collatz_Path(ℂ₁gCP(α,𝔾,σ)...)
	elseif !haskey(𝔾.nodes, α) && (α % 2 != 0)
		return get_Collatz_Path(ℂ₂gCP(α, 𝔾, σ)...)
	end
end

p014(α) = p014(α, Graph())
function p014(α::Int, 𝕘::graph)::Tuple{Int, Int, graph, Vector{Number}}
	𝔾 = 𝕘; ℝ = [1:α;]; Β = 0; β = 0; α = []
	for element ∈ ℝ
		a = get_Collatz_Path(element,𝔾)[3]; λ = length(a)
		if λ > Β
			Β = λ; β = element; α = a
		end
	end
	return (Β, β, 𝔾, α)
end

## Old Brute solution

ρ_Collatz(α::Int) =  ρ_Collatz(α, Array{Int, 1}())
ρ_Collatz(β::Int, λ₀::Int, λ₁::Int) = ρ_Collatz(β*(λ₀^λ₁))
function ρ_Collatz(α::Int, σ::Array{Int, 1})::Array{Int, 1}
	if α == 1
		return σ
	else
		append!(σ, Collatz(α)); α = Collatz(α)
		return ρ_Collatz(α, σ)
	end
end

function _p014(α::Int)::Int
	Λ = [1:α;]; β = 0; len_β = 0;
	for λ = Λ
		ρ = length(ρ_Collatz(λ)) 
		if ρ > len_β
			β = λ; len_β = ρ;
		end
	end
	return β
end
