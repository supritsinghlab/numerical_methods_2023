# calculation of the coefficients to the 2ᵏ derivative for 2r+1 point formalism.
# calculation of the coefficients to the 2ᵏ derivative for 2r+1 point formalism.
function coeff_2kth_derivative(r,k = 1)
    #k = 0:r-1
    n = 2*r+1
    A = zeros(Rational,r,r)
    #display(A)
    for i in 1:r
        for j in 1:r
            A[i,j] = (i)^(2*j)//(factorial(2*j))
        end
    end
    #display(A)
    B = inv(A)
    #display(B)
    R = zeros(Rational,r,2*r+1)
    #display(R)
    for i in 1:r
            R[i,r+1] = -2
            R[i,r+i+1] = 1
            R[i,r-i+1] = 1
    end
    #display(R)
    F = B*R/2
    #display(F)
    C = zeros(Rational,1,n)
    #display(C)
    #println("The coefficient of second order derivative ($n point formula) are")
    #println("----------------------------------------------------------------------")
    for k in 1:n
        C[1,k] = F[1,k]
    end
    return C[k,r+1:end]
end