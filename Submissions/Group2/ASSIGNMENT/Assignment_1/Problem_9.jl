# Problem 9

# Finding coefficients in derivative expansion
function Coef(r)
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
    println(Coef(i))
end
