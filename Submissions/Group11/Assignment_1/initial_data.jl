#=
# The Julia snnipet defines a function and plots
# the function over a specified interval. Saves the
# plot as "test_plot.png" in the current working directory
=#

using Plots
foo(x::Number) = exp(-x*x)
i = -10.0:0.1:10.0
gr()
global fi = []
for j in i
	push!(fi,foo.(j))

end
plot(i,fi, ylabel="y", xlabel = "x",label="exp(-x^2)")
savefig("test_plot.png")
