include("node.jl")
include("graph.jl")

α = Node("α", [1, 2, 3])
β = Node("β", [3, 2, 1])
ν = Node()

γ = Graph()
add_node(γ, α)
add_node(γ, β)
add_node(γ, ν)
