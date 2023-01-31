using SparseArrays
using LinearAlgebra

function values(r)
#r= order of accuracy
mat=zeros(r,r) #the coefficient of derivatives of y matrix
for i=1:r
for j=1:r
mat[i,j]=2*(i)^(2*j)/factorial(2*j)
end
end 
Mi=mat^-1;
colm=Mi*ones(r)*(-2);
ck =Mi[1,:];
return cat(colm[1],ck,dims=1) #k=0 first
end


println("type run(r,J) to generate JxJ second derivative matrix using 2*r+1 point formula\n\n")
function run(r,J)
c=values(r)
coeff=[c[abs(i)+1]*ones(J-abs(i)) for i=-r:r ] #bands
pos=collect(-r:r)
Dsq=spdiagm(J,J,(pos.=>coeff)...)
display(Dsq)
end
#@time run()
