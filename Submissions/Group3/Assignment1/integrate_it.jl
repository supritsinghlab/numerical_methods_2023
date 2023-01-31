function myfunction(x)
return exp(-0.1*x^2)*x^2
end

function area(fn,dx)#using Simpson's 1/3 rule
n=length(fn)
area=fn[1]+fn[n] #add endpoints first as they're simple.

for i=2:n-1
area+= (4-2*(i%2))*fn[i] #alternate the coefficients as 4 or 2 for other points
end

area=dx*(area)/3 #multiply by stepsize/3
return area

end




function main()
#Step size in position: dx
dx=0.01
#The domain x:
x=-10:dx:10

#discretize the function on the domain
f= @. myfunction(x)
A=area(f,dx)
println("The area under the curve for the given function is: ",A,"\n\n")
end
@time main()
