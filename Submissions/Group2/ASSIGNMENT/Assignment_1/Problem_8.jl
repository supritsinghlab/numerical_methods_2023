
# Problem 8

function Wavefunction(x)
    return exp(-x^2)
end


# Using Rectangular method
N1 = sum(Ψ) * dx
println("The integral using Rectangular method is "*string(N1))

# Integrating Using Simpson Method
function Simpson(func,A, B ,N)
    h   = (B − A) / (N − 1) # step size
    sum = ( func(A)+ func(B) ) 
    
    for i = 1:2:N-1
        sum += 4*func(A+i *h)
    end
    
    for i = 2:2:N-2
        sum += 2*func(A+i *h)
    end
return h*sum/3
end

N2 =Simpson(Wavefunction,-10, 10 ,1001)
println("The integral using Simpson method is "*string(N2))

