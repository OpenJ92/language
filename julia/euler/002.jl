function fib(a::Int, b::Int, accumulator::Int)::Int
  c::Int = a + b
  if c >= 4e6 return accumulator end
  accumulator += c%2==0 ? c : 0
  return fib(b,c,accumulator)
end

fib(a::Int, b::Int) = fib(a, b, 0)
fib() = fib(1, 1)
