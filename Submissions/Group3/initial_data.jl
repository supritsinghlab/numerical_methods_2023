using Plots

function myfunction(x)
return exp(-0.1*x^2)*x^2
end

function main()
#Step size in position: dx
dx=0.01
#The domain x:
x=-10:dx:10

#discretize the function on the domain
f= @. myfunction(x)
p=plot(x,f,linewidth=3,legend=false,linecolor=:red,title="My wavefunction",grid=true,gridlinewidth=3,gridstyle=:dot,gridalpha=0.7,xtickfontsize=20,ytickfontsize=20,titlefontsize=20)  
end
@time main()
