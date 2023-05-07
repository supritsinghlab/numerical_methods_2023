using Plots
f(x::Number) = exp(-x^2)
i = -10:0.1:10
Arrrayi = collect(i)
plot(i,f.(i))