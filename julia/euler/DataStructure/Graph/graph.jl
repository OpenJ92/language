Graph() = graph(Dict(Nothing=>Nothing))
Graph(nodes) = graph(nodes)
mutable struct graph
	nodes::Dict{Any, Any}
end

function add_node(γ::graph, ν::node)
	γ.nodes[ν.name] = ν
end

function get_node(γ::graph, ν::Int)
	return γ.nodes[ν]	
end
