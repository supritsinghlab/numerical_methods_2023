using LinearAlgebra
using DataFrames

# Define maximum value of r for which to generate the second derivatives coefficient table
r_max = 7


# Create an empty table
coeff_table = zeros(r_max,r_max + 1)

for r in range(start=1, stop=r_max, step=1)
    
    # Create rxr matrix
    mat1 = zeros(r,r)
    for i in 1:r
        for j in 1:r
            mat1[i,j] = 2*(i^(2*j))/factorial(2j) 
        end
    end
    
    # Create rx2r+1 matrix
    # RHS Matrix can be thought of as the concatenation of three different matrices
    mat2 = hcat(rotr90(Matrix(I,r,r)), fill(-2, r), Matrix(I,r,r))
    
    mat3 = inv(mat1)*mat2
    
    global coeff_table[r,1:r+1] = mat3[1,r+1:(2r+1)] 
end

# Create a table
DataFrame(coeff_table, ["k=0","1","2","3","4","5","6","7"]) 