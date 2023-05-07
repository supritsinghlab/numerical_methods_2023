using PyPlot
function wavefunction(x)           #User defined wavefunction
    return exp(-x^2)
end
x=collect(-10:0.001:10)            #Domain of x
wf=wavefunction.(x)
p =plot(x,wf)                      #Plot for wavefunction
xlabel("x")
ylabel("Wavefunction")
display(p)