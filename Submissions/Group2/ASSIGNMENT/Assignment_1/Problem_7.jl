#problem 7
using PyPlot
using SparseArrays: spdiagm

function run()
function Wavefunction(x)
    return exp(-x^2)
end

dx=0.001
L=10
x = collect(-L:dx:L)
n=length(x)
Ψ = Wavefunction.(x)
p =plot(x,Ψ)
xlabel("x")
ylabel("Psi(x)")
display(p)
end

@time run()
