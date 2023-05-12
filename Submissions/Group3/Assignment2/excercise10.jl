#Monojit Chatterjee,2021PHS7199

using Plots
using LinearAlgebra

function run()
#The data as in exercise 1
xpts=[203,58,210,202,198,158,165,201,157,131,166,160,186,125,218,146]
Y=[495,173,479,504,510,416,393,442,317,311,400,337,423,334,533,344]
sigy=[21,15,27,14,30,16,14,25,52,16,34,31,42,26,16,22]

xptsnew=vcat([201,244,47,287],xpts) #For data in exercise 2
Ynew=vcat([592,401,583,402],Y)
sigynew=vcat([61,25,38,15],sigy)

n=length(xpts)
A=hcat(ones(n),xpts)
C_inv=diagm(sigy)^-1


X=(A'*C_inv*A)^-1*A'*C_inv*Y #This minimises the chi-squared error.
chi_sqr= (Y-A*X)'*C_inv*(Y-A*X)

b=X[1] #the slope and intercept
m=X[2]








n_new=length(xptsnew)
A_new=hcat(ones(n_new),xptsnew)
C_inv_new=diagm(sigynew)^-1

Xnew=(A_new'*C_inv_new*A_new)^-1*A_new'*C_inv_new*Ynew #This minimises the chi-squared error.
chi_sqr_new= (Ynew-A_new*Xnew)'*C_inv_new*(Ynew-A_new*Xnew)



println("\nThe Chi^2 for exercise 1 is")
display(chi_sqr)
println("\n\nThe Chi^2 for exercise 2(with more outliers) is")
display(chi_sqr_new)



end

@time run()
