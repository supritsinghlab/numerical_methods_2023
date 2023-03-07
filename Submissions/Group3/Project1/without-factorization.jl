using SparseArrays
using LinearAlgebra
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

function normalize(psi,dx)#normalize the function 
return psi/sqrt(area([p*conj(p) for p in psi],dx))
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





function T(k) #Taylor coefficients of the function
return 1/factorial(k) #exp(x)'s coeff
end

function q(M,k)
if k<0 ||k>M
return 0
else
mat=[T(M-j+i) for i=1:M,j=1:M]
rhs=[-T(M+k) for k=1:M]
B=mat\rhs #Find b_i values from the last M eqns
B=vcat([1],B) #b0=1
return B[k+1]
end
end



function run()
dx=0.01; dt=0.1; 

r=3
M=4 #degree of Pade approximant
M=M


x=-10:dx:10;

J=length(x)
tmax=50




p=[sum([T(l)*q(M,k-l) for l=0:k]) for k=0:M] #Solving for a_i from the b_i values we got.
NUM=p
DEN=[q(M,k) for k=0:M]

#f = @. exp(-0.5*(x)^2) #initial state vector
f = @. exp(im*2*x)*exp(-3*(x)^2) #initial state vector
f=normalize(f,dx)
c=values(r)

coeff=[c[abs(i)+1]*ones(J-abs(i)) for i=-r:r ] #bands
pos=collect(-r:r)
Dsq=spdiagm(J,J,(pos.=>coeff)...)/(dx^2)
#pot=@. 0.5*x^2 #Harmonic oscillator
pot=zeros(J)
#pot= @. 2*(sign(x-2)+1)
V=Diagonal(pot)

H=-Dsq+V

#A = I(J)+0.5*im*dt*H
#B = I(J)-0.5*im*dt*H
z=im*dt*H

A=spzeros(J,J);
B=spzeros(J,J);

for i=0:M
A+=NUM[i+1]*z^i
B+=DEN[i+1]*z^i
end

display(area(abs.(f.^2),dx))


for i=1:tmax
#p=plot(x,@. real(f);label="real")
#plot!(p,x,@. imag(f);label="imag")
p=plot(x,@. abs.(f)^2;legend=false)
#plot!(p,x,pot)
#ylims!(0,2)
title!("t="*string(round((i-1)*dt,digits=2)))

isdir("images") || mkdir("images") #create a directory called "images" if it doesn't already exist.
png("images/img"*lpad(i,4,"0"))

rhs=B*f ##next time use Sparse LU decomposition
f=A\rhs
end
display(area(abs.(f.^2),dx))

end
@time run()
