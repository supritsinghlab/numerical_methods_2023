using Plots

# x belongs to [-10,10]
x = LinRange(-10,10,1000)

# User defined function f(x)
f(xi) = xi.^2

gr()

plot(x,f(x),label="f(x)")
xlabel!("x →")
ylabel!("y = f(x) →")
title!("Plot of f(x)")