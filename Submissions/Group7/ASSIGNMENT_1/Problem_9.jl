#ASSIGNMENT 1
#GROUP 7; Pawan Goswami, 2019PH10645 ;
#Shubham Basera, 2021PHS7223

#PROBLEM 9
#Write a Julia Snippet to generate a table giving co-efficients of the second #derivative expansion in terms of the discretized function elements.

function run()
# Defining the function to calculate the coefficients in derivative expansion
function Coefficients(r)
M = zeros(r,r)
for i =1:r
    for j =1:r
        M[i,j] = 2 * (i)^(2*j) / factorial(2*j)
    end
end  
Mi=M^-1;
colm=Mi*ones(r)*(-2);
ck =Mi[1,:];
return cat(colm[1],ck,dims=1) #k=0 first
end

# Defining the r till where the table will be generated
r = 7

# Printing the table
for i=1:r
    print("r="*string(i)*"  ")
    println(["$v " for v in Coefficients(i)]...)
    #println("r="*string(i)*string(Coefficients(i)))
end

end

@time run()
