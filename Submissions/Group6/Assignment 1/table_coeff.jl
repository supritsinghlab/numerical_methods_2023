using LinearAlgebra

function table_coeff(r)
    
    A = zeros(r,r)
    B = [i^2 for i in 1:r]
    
    for i in 1:r
        A[:,i] = (B.^i)/factorial(2*i)
    end

    A = 2*A
    b = zeros(r,(2*r)+1)

    for i in 1:r
        temp = zeros((2*r)+1)
        temp[r+1] = -2
        temp[r-i+1], temp[r+i+1] = 1, 1
        b[i,:] = temp
    end

    coeff = lu(A)\b
    return coeff[1,r+1:end]

end

function table(r)
    
    return [table_coeff(r[i]) for i in eachindex(r)]

end

println(table([1,5,7]))