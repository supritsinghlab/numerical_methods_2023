#Monojit Chatterjee,2021PHS7199

using Plots
using LinearAlgebra

function run()
xpts=[203,58,210,202,198,158,165,201,157,131,166,160,186,125,218,146]
Y=[495,173,479,504,510,416,393,442,317,311,400,337,423,334,533,344]
sigy=[21,15,27,14,30,16,14,25,52,16,34,31,42,26,16,22]

n=length(xpts)
A=hcat(ones(n),xpts)
A=hcat(A,xpts.^2)
display(A)
C_inv=diagm(sigy)^-1

X=(A'*C_inv*A)^-1*A'*C_inv*Y

b=X[1]
m=X[2]
q=X[3]

x=0:1:maximum(xpts)#equispaced

p=scatter(xpts,Y,label="data",yerror=sigy,legend=:bottomright)
display(p)

p2=plot!(p,q.*x.*x+m.*x.+b,label="best fit quadratic curve")
display(p2)
png("plot3.png")
println("The best curve has parameters, m:",string(m)," , b: ",string(b)," and q:",string(q))

end

@time run()
