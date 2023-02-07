using LinearAlgebra
function coefficients(r)                      #Gives coefficients for upto r value
    M=zeros(r,r+1)
    for k in 1:r
        mat=zeros(k,k)
        for i in 1:k
            for j in 1:k
                mat[i,j]=2*i^(2*j)/factorial(big(2*j))
            end
        end
        Inv=inv(mat)[k,1:end]
        M[k,1]=-2*sum(inv(mat)[1,1:end])
        M[k,2:k+1]=inv(mat)[1,1:end]
    end
    return M
end

C=coefficients(7)
println(C)