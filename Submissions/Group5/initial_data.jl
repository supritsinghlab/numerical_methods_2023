using Plots

function myFunction(x)
   return sin.(x)
end

x = range(-10,10,length=100)
y = myFunction(x)
plot(x,y)