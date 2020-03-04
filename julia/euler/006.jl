function sum_(array::Array{Int, 1})::Int
  return sum(array)
end

function square(x::Int)::Int
  return x*x
end

function square(array::Array{Int, 1})::Array{Int, 1}
  return map(square, array)
end

function _006(array::Array{Int, 1})::Int
  return square(sum(array)) - sum(square(array))
end
