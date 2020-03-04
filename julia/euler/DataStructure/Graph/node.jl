Node() = node(Nothing, Nothing, [Nothing], [Nothing])
Node(name) = node(name, [], [], [])
Node(name, data) = node(name, data, [], [])
mutable struct node
	name::Any
	data::Any
	parents::Array{Any, 1}
	children::Array{Any, 1}
end

function add_parent(self::node, other::node)
	push!(self.parents, other)	
end

function add_child(self::node, other::node)
	push!(self.children, other)	
end

function make_family(parent::node, child::node)
	add_parent(child, parent); add_child(parent, child);
end
