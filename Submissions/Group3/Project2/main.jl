using DelimitedFiles
using Distributions
using Plots

function area(fn,dx)#using Simpson's 1/3 rule
n=length(fn)
area=fn[1]+fn[n]

for i=2:n-1
area+= (4-2*(i%2))*fn[i]
end
area=dx*(area)/3
return area
end



#-----------------------------------------------------------------------------------------





function DM_LSS(h,Zmax) ##my calculation on paper.
Omega_m_h_sq=0.143#.143(main paper) or .315(other paper) or .29(website https://ned.ipac.caltech.edu/level5/Sept02/Roos/Roos6.html)
#output is in the units of pc/cm^3

dz=0.0001
z=0:dz:Zmax

arr= @. (1+z)/sqrt(Omega_m_h_sq*(1+z)^3 + h^2-Omega_m_h_sq)
intg=area(arr,dz)

return 557.34*intg #to convert to pc/cm^3
end

#-----------------------------------------------------------------------------------------
function CDF(z)
return 2*(1 - (1+7*z+24.5*z^2)*exp(-7*z))/343
end

function main()
max=CDF(10) #for z=10, the limiting value of CDF
y=rand(Uniform(0,max),500) #500  uniform random numbers b/w 0 and max
Z=zeros(500)  
for i=1:500
f(z)=CDF(z)-y[i]
Z[i]=find_zero(f,0.5) #find the z for which CDF will be given random number
end
#p=histogram(z,bins=50)   #Plot and see z^2*exp(-7z) distribution

#-------------------------------------z's found----------------
DM=zeros(500)
SIG=zeros(500)

for i=1:500
z=Z[i]
lss=DM_LSS(0.629,z) #h=.629
host=100/(1+z)

DM[i]=lss+host
SIG[i]=50/(1+z) + 30+ (40+140*z)
end
FINAL=hcat(Z,DM,SIG)
writedlm("output.csv",FINAL,",")
end

@time main()
