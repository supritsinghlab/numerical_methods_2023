#Monojit Chatterjee,2021PHS7199

using Plots
using LinearAlgebra

function Chi_sq(S,xpts,Y)
#The data as in exercise 1

n=length(xpts)
sigy=S*ones(n)

A=hcat(ones(n),xpts)
C_inv=diagm(sigy)^-1


X=(A'*C_inv*A)^-1*A'*C_inv*Y #This minimises the chi-squared error.
chi_sqr= (Y-A*X)'*C_inv*(Y-A*X)
return chi_sqr
end

function run()
xpts=[203,58,210,202,198,158,165,201,157,131,166,160,186,125,218,146]
Y=[495,173,479,504,510,416,393,442,317,311,400,337,423,334,533,344]

sigy_sqr=sort([21,15,27,14,30,16,14,25,52,16,34,31,42,26,16,22] .^2)
median=0.5*(sigy_sqr[8]+sigy_sqr[9])
mean=sum(sigy_sqr)/16

N=1000
Svals=LinRange(100,1400,N)
Chi_vals=zeros(N)

for i=1:N
S=Svals[i]
Chi_vals[i]=Chi_sq(S,xpts,Y)
end
p=plot(Svals,Chi_vals,ylim=(6,24),yticks=collect(6:2:24),xlim=(100,1400),xticks=collect(100:100:1400))
plot!(p,Svals,ones(N)*14,linestyle=:dot)
display(p)

println("\nS for which Chi-squared is nearest to 14.0 is:")
S_near= argmin( abs.(Chi_vals .- 14)) #find element nearest to 14
println(Svals[S_near])
println("Uncertainity Variances:- median: ",median," | mean= ",mean,"\n\n")
end

@time run()
