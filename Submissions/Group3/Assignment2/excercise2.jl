#Monojit Chatterjee,2021PHS7199

using Plots
using LinearAlgebra

function run()
#The new data, including first four points of the table
xpts=[201,244,47,287,203,58,210,202,198,158,165,201,157,131,166,160,186,125,218,146]
Y=[592,401,583,402,495,173,479,504,510,416,393,442,317,311,400,337,423,334,533,344]
sigy=[61,25,38,15,21,15,27,14,30,16,14,25,52,16,34,31,42,26,16,22]

n=length(xpts)
A=hcat(ones(n),xpts)
C_inv=diagm(sigy)^-1

X=(A'*C_inv*A)^-1*A'*C_inv*Y

b=X[1]
m=X[2]

x=0:1:maximum(xpts)#equispaced points for the best fit line

p=scatter(xpts,Y,label="data",yerror=sigy,legend=:bottomright)
display(p)

p2=plot!(p,m.*x.+b,label="best fit line")
display(p2)
png("plot2.png")
println("The best fit line has slope:",string(m)," and intercept: ",string(b),"\n\n")
println("The sigma_m uncertainity matrix is:\n")
display((A'*C_inv*A)^-1)
end

@time run()
