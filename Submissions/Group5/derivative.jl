using Printf
h = 1         #This does not affect the final values
Rrange = 10    # the range of r till which coefficients are desired

for r in 1:Rrange
    local coeffMatrix = zeros(Float64, r, r)
    for row in 1:r
        for col in 1:r
            coeffMatrix[row, col] = 2*((row*h)^(col*2))/factorial(2*col)  #Updating the coefficient matrix for linear system
        end
    end
    local inverse = inv(coeffMatrix)                                      #Inverting the matrix

    @printf "%.4f" (h^2)*(-2*sum(inverse[1, :]))                          #Print the coeff for k=0 by appropriate comparison
    for i in 1:r
        print(" ")                                  
        @printf "%.4f" inverse[1, i]                                      #Print all other coeff by appropriate comparison
    end
    print("\n")
end