using LinearAlgebra

function values(r)
#r= order of accuracy
mat=zeros(r,r) #the coefficient of derivatives of y matrix
for i=1:r
for j=1:r
mat[i,j]=2*(i)^(2*j)/factorial(2*j) #coefficients of the terms that make up the series. Given in the paper.
end
end 
Mi=mat^-1;
colm=Mi*ones(r)*(-2);
ck =Mi[1,:];
return cat(colm[1],ck,dims=1) #k=0 first
end



function run()
rmax=5
title="r  "

for k=1:rmax+1
title*="k="*string(k-1)*"       "
end



println("\n\n",title)
for r=1:rmax
title*="  k="*string(r-1)

val=values(r)
s=string(r)*"  "*string(rpad(round(val[1],digits=4),6,"0"))*"   "

for k=2:r+1
s*=string(rpad(round(val[k],digits=4),6,"0"))*"   "

end

println(s)

end
println("\n\n")
end
@time run()
