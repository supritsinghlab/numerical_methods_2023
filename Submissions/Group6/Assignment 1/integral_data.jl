include("initial_data.jl")
using QuadGK

# Integral domain is from [-10,10]
a, b = -10, 10

I = quadgk(f,a,b)[1]

println(I)