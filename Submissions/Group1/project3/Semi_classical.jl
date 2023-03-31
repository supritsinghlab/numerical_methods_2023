using LinearAlgebra
using Plots
using Tensorial

#defing parameters
g1 = 1.5
g2=1.5
lambda=2
ws=2

#Defining Initial Spin states for spin 1 and spin 2
Chi_u=[1,0]
Chi_d=[0,1]

Spin_state= (kron(Chi_u,Chi_u))/sqrt(1)
#Defining the operators
sigma_p=[0 1;0 0]
sigma_m=[0 0 ; 1 0 ]
sigma_z=[1 0;0 -1]
Id= [1 0 ; 0 1]


# Defining initial x and p
x_0= 0.1
p_0=0

#Steps
N= 1000000

#dt
dt=0.0001

#x and p arrays and Energy and Entropy arrays
Nd=Int(0.001/dt)
x=zeros(N)
xf=zeros(Int(N/Nd))
p=zeros(N)
pf=zeros(Int(N/Nd))
x[1]=x_0
p[1]= p_0

Entrop=zeros(Int(N/Nd))
Energy_o = zeros(Int(N/Nd))
Ess = zeros(Int(N/Nd))
            
#defining hamiltonion

function H(x,p)
    a=(x+complex(0,1)*p)/sqrt(2)
    a_d = (x+complex(0,-1)*p)/sqrt(2)
    H = (0.5* p^2 + 0.5* x^2)*kron(Id,Id)+0.5*g1*(a*kron(sigma_p,Id)+a_d*kron(sigma_m,Id))+ 0.5*g2*(a*kron(Id,sigma_p)+a_d*kron(Id,sigma_m))
    return H    
end
function H2(x,p)
    a=(x+complex(0,1)*p)/sqrt(2)
    a_d = (x+complex(0,-1)*p)/sqrt(2)
    H = 0.5*g1*(a*kron(sigma_p,Id)+a_d*kron(sigma_m,Id))+ 0.5*g2*(a*kron(Id,sigma_p)+a_d*kron(Id,sigma_m))+0.5*lambda*(kron(sigma_p,sigma_m)+kron(sigma_m,sigma_p))+0.5*ws*(kron(sigma_z,Id)+kron(Id,sigma_z))
    return H    
end
function Entropy(state)
    rho=state*state'
    entr=0
    entr=entr+real((rho[1,1]+rho[2,2])*log(complex(rho[1,1]+rho[2,2])))
    entr=entr+real(rho[4,4]+rho[3,3])*log(complex(rho[4,4]+rho[3,3]))
    return -1*entr
end
kId=kron(Id,Id)

#Time evolution
for i in collect(1:1:N-1)
    global Spin_state
    global kId
    global x
    global p
    global xf 
    global pf
    
    A=H(x[i],p[i])
    B=H2(x[i],p[i])
    
    Spin_state= (kId - complex(0,0.5*dt).*B)/ (kId + complex(0,0.5*dt).*B)*Spin_state
    x[i+1]=x[i]+real(dt*Spin_state' *(H(x[i],p[i]+0.0001)-A)*Spin_state/0.0001)
    p[i+1]=p[i]-real(dt*Spin_state' *(H(x[i]+0.0001,p[i])-A)*Spin_state/0.0001)
    
    if i%Nd==1
        xf[Int((i-1)/Nd)+1]=x[i]
        pf[Int((i-1)/Nd)+1]=p[i]
        Energy_o[Int((i-1)/Nd)+1]=0.5*p[i]^2 + 0.5*x[i]^2
        Ess[Int((i-1)/Nd)+1]=real(Spin_state'*B*Spin_state)
        Entrop[Int((i-1)/Nd)+1]=Entropy(Spin_state)

    end
    
end


plot_array = [] 
push!(plot_array,plot(xf,pf, ms=1,ylabel="p",xlabel="x",legend=false))
push!(plot_array,plot(dt*Nd*collect(1:1:N/Nd),Entrop, ms=1,legend=false,ylims=(0,0.7),ylabel="Entropy",xlabel="time"))
push!(plot_array,plot(dt*Nd*collect(1:1:N/Nd),Ess, ms=1,legend=false,ylabel="Ess",xlabel="time"))
push!(plot_array,plot(dt*Nd*collect(1:1:N/Nd),Energy_o,legend=false, ms=1,ylabel="Eo",xlabel="time"))
plot(plot_array...) # note the "..."
