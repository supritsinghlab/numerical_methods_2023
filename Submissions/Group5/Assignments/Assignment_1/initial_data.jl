using Plots

function myFunction(x)
   sig=0.5
   mu=0
   return exp(-((x - mu)^2.0) / (2 * ((sig)^ 2.0)))  #Gaussiam
   # return cos.(x)              
end

x = range(-10,10,step = 0.001)                       #Iterating over x, storing corresponding values of y and plotting.
y = Vector{Float64}()

for i in eachindex(x)
    push!(y,myFunction(x[i]))
end
plot(x,y)