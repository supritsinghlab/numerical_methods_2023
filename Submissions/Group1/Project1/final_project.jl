using LinearAlgebra
using SparseArrays
using Plots
#project1 starts
#defining a function , choosing gaussian function
#################################################################################
#start time 1
t1=time_ns()
#################################################################################

#value of l and parameters
l=50
# a of gaussian wavefunction exp(-ax^2 + ibx)
a=10
b=1
# Number of divisions in x
N=10001

# final T
T=4
#value of r for point formula, number of points is 2r+1
r=3
#Value of M used
M=2

#step size in time
dt=0.01
N2=Int(T/dt)

#defining x array
x=range(-l,l,length=N)

#step size
h=x[2]-x[1]

################################################################################
#defining a function for integration
function integrate(x,y)
    
    d1=0 #dummy variables
    d2=0
    for i in collect(1:2:N)
        d1=d1+y[i]
    end
    for i in collect(2:2:N)
        d2=d2+y[i]
    end
    h=x[2]-x[1]
    #simpson integration rule
    integral2=(y[1]+y[end]+2*d1+4*d2)*h/3
    
    return integral2
end
####################################################################################
#defining sparse matrix for single derivative

#get the coefficient from coefficients program
coefficients=[[1.0, -2.0, 1.0],[-0.08333333, 1.33333333, -2.5, 1.33333333, -0.08333333],[0.01111111, -0.15, 1.5, -2.72222222, 1.5, -0.15, 0.01111111],[-0.00178571, 0.02539683, -0.2, 1.6, -2.84722222, 1.6, -0.2, 0.02539683, -0.00178571],[0.00031746, -0.00496032, 0.03968254, -0.23809524, 1.66666667, -2.92722222, 1.66666667, -0.23809524, 0.03968254, -0.00496032, 0.00031746]]
#number of points used in formula
num_coeff=length(coefficients[r])

#value of r
k=Int((num_coeff-1)/2)

#####################################################################################
#creating sparse matrix for operations
H=sparse(zeros(N,N))

#assigning the coefficients in H matrix

for i in collect(r:1:N-r)
    #to check for negative indices at the start and the large indices at the end  
    # k is value of r
    if i-k <= 0
        m1=i-k+1
        m2=k
    elseif i+k > N
        m1=-k
        m2 = i+k-N-1
    else
        m1=-k
        m2=k
    end
    #end of checking
    #plugging in 
    for j in collect(m1:1:m2)
            H[i,i+j]=coefficients[r][abs(j+k)+1]
    end
end
t2=time_ns()

print("H matrix computed \n")
print("time upto now  ",(t2-t1)/1e9)

##########################################################################################
#Creating Pade' approximant matrix Ks and A (ultimate operator)
# z_s value array
z_s=[complex(-4.64437,0) complex(-3.67881,-3.50876) complex(-3.67881,3.50876)]
#value of M
M=length(z_s)

#creating sparse Identity 
Id=sparse(I,N,N)  

#creating A operator which will increment in time
H=(-1/(2*h^2)).*H
A=sparse(I,N,N)
A1=sparse(I,N,N)
d6= complex(0,1)*dt

### computing A matrix from K_s matrix
for s in collect(1:1:M)
    global A
    A = A*(Id+(d6/z_s[s]).*H)
    global A1
    A1 = A1*(Id-(d6/conj(z_s[s])).*H)
end
A=sparse(round.(A,digits=13))
A1=sparse(round.(A1,digits=13))

t3=time_ns()

print("\n A matrices computed , time spent in this and overall  ", (t3-t2)/1e9, "  ", (t3-t1)/1e9)
#######################################################################################################

#Solving the equation, initiating Matrix to store wavefunctions
Psi_f=complex.(zeros(N,N2))
                
#Initial Wavefunction
Psi_f[:,1]=((2*a/pi)^0.25).*exp.(-a*x.*x +complex(0,b).*x)

#Solving time increment and storing it in matrix
for i in collect(2:1:N2)
    Psi_f[:,i]= A1 \ (A*Psi_f[:,i-1])
end

t4=time_ns()
print("\n Solved the time evolution in ",(t4-t3)/1e9, "  total time = ", (t4-t1)/1e9)

#########################################################################################################
#Animating
    
#using Plots
#anim = @animate for i in collect(1:1:N2)
 #   plot(x, abs.(Psi_f[:,i]), legend=false, ylims=(0,1))
#end
    
#gif(anim, "wavefunction_evolution.gif", fps = 30)
##########################################################################################################
#error analysis

t_sigma= 3/(2*b*sqrt(a)) # 3 refers to displacement of  mean by 3 sigma
n_tsigma= Int(round(t_sigma/dt))
t_theory= n_tsigma*dt
Psi_theory= ((((sqrt(pi/(2*a))*(1+(2*complex(0,1)*a*t_theory)))^(-0.5)))*exp(complex(0,-0.5*(t_theory*(b^2))))).*exp.(-1*(a/(complex(1,2*a*t_theory))).*(x.-(b*t_theory)).^2).*exp.(complex(0,b).*x)
error_x= Psi_f[:,n_tsigma+1].-Psi_theory

total_error = integrate(x,(abs.(error_x).^2))
print("\n total error = ", total_error)
plot(x,abs.(error_x))

print("\n\n",(t4-t1)/1e9," | ", total_error)