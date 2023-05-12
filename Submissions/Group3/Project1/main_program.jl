using SparseArrays
using LinearAlgebra
using Plots
using DelimitedFiles



function area(fn,dx)#using Simpson's 1/3 rule
n=length(fn)
area=fn[1]+fn[n]

for i=2:n-1
area+= (4-2*(i%2))*fn[i]
end
area=dx*(area)/3
return area
end

function normalize(psi,dx)#normalize the function 
return psi/sqrt(area(psi.*conj(psi),dx))
end

function values(r) #Generate the table of coefficients
mat=zeros(r,r)
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


#The following function is written by Manoj. It returns the Pade factors from the saved data files.
#Those data files were generated using PadeApproximants.jl, also written by Manoj. Rest is by Monojit.

function GetPadeApproximantRootsFiles(nOrder, dOrder, folderPath)
    readData = readlines("$(folderPath)/PadeApproxRootsNumOrder$(nOrder).csv")
    vecTemp = split(readData[dOrder], ",")

    vecTempComplex = Vector{ComplexF64}()
    for i in vecTemp
        push!(vecTempComplex, parse(ComplexF64, i))
    end
    return vecTempComplex    
end


function run()
dx=0.01; dt=0.01; 

r=2 #order of approximation in spatial second derivative
M=3 #degree of Pade approximant
tmax=400 #no. of time steps. So actual Tfinal=tmax*dt


x=-10:dx:10; #the domains
J=length(x)


f = @. exp(im*2*x)*exp(-3*(x)^2) #initial state vector


pot=zeros(J) #free particle
#pot=@. 2*x^2 #Harmonic oscillator potential
#pot= @. 2*(sign(x-2)+1)  #Step potential.




f=normalize(f,dx)
c=values(r)

coeff=[c[abs(i)+1]*ones(J-abs(i)) for i=-r:r ] #bands
pos=collect(-r:r)
Dsq=spdiagm(J,J,(pos.=>coeff)...)/(dx^2)


V=Diagonal(pot)

H=-Dsq+V
z=im*dt*H #hbar=1, 2m=1

myroots = GetPadeApproximantRootsFiles(M,M,"./papprox") #this directory contains the data files. Must exist.
myNumeratorRoots= myroots[1:M]
myDenominatorRoots = myroots[M+1:2*M]

A=I(J)
B=I(J)
for order=1:M
A=A*( I(J)-z/myNumeratorRoots[order]  )
B=B*( I(J)-z/myDenominatorRoots[order])
end

for i=1:tmax
p=plot(x,@. abs(f)^2;legend=false)
plot!(p,x,pot)
ylims!(0,2.2)
title!("t="*string(round((i-1)*dt,digits=2)))

isdir("images") || mkdir("images") #create a directory called "images" if it doesn't already exist.
#save the plot:
png("images/img"*lpad(i,4,"0"))    #Pad the filenames with zeros to have a consistent format. Helps FFMPEG.

rhs=B*f #Solve the system. Cheaper than inverting the sparse matrix and multiplying it.
f=A\rhs

end

end
@time run()
