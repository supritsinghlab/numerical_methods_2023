using Plots
using LinearAlgebra

function logM(A) #approximate the log of a matrix by a short Taylor expansion
B=A.-I(2)
return B .- B*B/2 .+B*B*B/3
end

function run()
#system parameters
ws=2
lambda=2

g1=1.5
g2=g1



m=1
w=1



dt=1e-5 #smaller values makes the evolution unstable. This system is highly nonlinear and chaotic.
N=5000000

psi=[1,0,0,0] #UU state. [0,1,0,0] is UD state.
q=0.1
p=0

a=(q+im*p)/sqrt(2*w)

Sigz=[1 0;0 -1]
Sigp=[0 1;0 0]
Sigm=[0 0;1 0]


Nby1000=convert(Int64,N/1000)

#arrays to store every 1000th point of the trajectory
P=zeros(Nby1000)
Q=zeros(Nby1000)
Ess=zeros(Nby1000)
Eo=zeros(Nby1000)
Sent=zeros(Nby1000)



for i=1:N

#Quantum Hamiltonian
Hq=0.5*ws*(kron(Sigz,I(2))+ kron(I(2),Sigz)) +
0.5*g1*kron(a*Sigp + conj(a)*Sigm,I(2))+
kron(I(2),0.5*g2*(a*Sigp + conj(a)*Sigm))+
0.5*lambda*(kron(Sigp,Sigm)+kron(Sigm,Sigp))

psi+=-im*Hq*psi*dt
#See the derivation.pdf
q+=dt*(p/m + psi'*( (im/sqrt(8*w))*(  kron(g1*Sigp-g1*Sigm,I(2)) +  kron(I(2),g2*Sigp-g2*Sigm)) )*psi )
p-=dt*(m*w*w*q + psi'*(  (1/sqrt(8*w))*(  kron(g1*Sigp+g1*Sigm,I(2)) +  kron(I(2),g2*Sigp+g2*Sigm)) )*psi )

a=(q+im*p)/sqrt(2*w)


if i%1000==0 #store every 1000th pt.
n=convert(Int64,i/1000)
P[n]=real(p)
Q[n]=real(q)
Ess[n]=real(psi'*Hq*psi)
Eo[n]=real(0.5*p^2/m+0.5*m*w*w*q*q)
rho=psi*psi'
rhoR=(rho[1,1]+rho[2,2])*rho[3:4,3:4]
Sent[n]=-real( tr( rhoR*logM(rhoR)) )
end

end






#plot and decorate

plt=plot(Q,P,title="g=1.5",xlabel="x",ylabel="p",label="")
plt2=plot([1:10000:N]*dt,Ess[1:10:Nby1000],label="",ylim=(1,2.2),yticks=[1,2.2],ylabel="Ess",xlabel="t")
plt3=plot([1:10000:N]*dt,Eo[1:10:Nby1000],label="",ylim=(0.0,1.5),yticks=[0.0,1.5],ylabel="Eo",margins = 2Plots.cm,xlabel="t")
plt4=plot([1:10000:N]*dt,Sent[1:10:Nby1000],label="",ylim=(0,0.5),yticks=[0,0.5],ylabel="S_ent",xlabel="t")

l=@layout[a{0.5h} ; [grid(3,1)] ]


PLOT=plot!(plt,plt2,plt3,plt4,layout=l,size=(800,1000))
display(PLOT)
#display(P)
end

@time run()
