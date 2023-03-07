# Project 1
Our aim is to develop program to calculate time evolution of a wavefunction . We have to use pade approximation of exponential to approximate time evolution operator.

Before that, we have to setup the environment. 
We have installed and the following in Ubuntu 20.04

* Julia 
* Jupyter notebooks
* Visual Studio Code

---
## Start of the project

We wish to make some special arguments before starting. Sampling of wavefunction must be within some limits as governed by **sampling theorem**. 

### Calculating the coefficients for derivatives from 2r+1 point formula
using the taylor expansion

$ f(x+mh)=\sum{ \frac{(mh)^{n}}{n!} f^{n}(x)}$
 
 we can construct any derivative as linear combination of value of function at many points

 $h^nf^{n}(x) = \sum_{k}{c_{nk}f(x+kh)}$

Code for coeffcients

```julia
#finding coefficinets for differetial matrix

#no. of points to use odd one
for m in collect(3:2:11)
    k=(m-1)/2
    M=zeros(m,m)
    #constructing mxm matrix
    k1 = -1*k
        for i in collect(1:1:m)
            for j in collect(1:1:m)
            j1=j-1
            M[i,j]= (k1)^j1/(factorial(j1))

        end
        k1=k1+1
    end
    print((round.(inv(M)[3,:],digits=5)))
    print("\n")
end

```
output looks like 
```
[1.0, -2.0, 1.0]
[-0.08333, 1.33333, -2.5, 1.33333, -0.08333]
[0.01111, -0.15, 1.5, -2.72222, 1.5, -0.15, 0.01111]
[-0.00179, 0.0254, -0.2, 1.6, -2.84722, 1.6, -0.2, 0.0254, -0.00179]
[0.00032, -0.00496, 0.03968, -0.2381, 1.66667, -2.92722, 1.66667, -0.2381, 0.03968, -0.00496, 0.00032] 
```
## Plot of function and integration

```julia
using Plots
l=10
x=range(-1*l,l,length=501)
h=x[2]-x[1]
y=[exp.(-1*x.*x)]
y1=exp.(-1*x.*x)
integral1 =0.0
for i in collect(1:1:length(x))
    integral1=integral1+y1[i]
end
integral1=integral1*h
d1=0.0
d2=0.0
for i in collect(1:2:length(x))
        global d1
        d1=d1+y1[i]
end
for i in collect(2:2:length(x))
        global d2
        d2=d2+y1[i]
end
integral2=(y1[1]+y1[end]+2*d1+4*d2)*h/3
print(integral1)
print("\n")
print(integral2)
print("\n")
print(sqrt(pi))
plot(x,y)
```

```
1.772453850905477
1.7724538509054781
1.7724538509055159
```
![ Basic Plot](/home/harsimran/Wavefunction_plot.png )

## Main algorithm for time evolution of free Particle 

```julia
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
N=1001

# final T
T=20
#value of r for point formula, number of points is 2r+1
r=5
#Value of M used
M=2

#step size in time
dt=0.1
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
#    plot(x, abs.(Psi_f[:,i]), legend=false, ylims=(0,1))
#end
    
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
```
## Testing the code
for different values of r for same M for T = 20, l= 50 

|    r    |M | delta x | delta t      | Computation time in s| error |
|  --------|----------| -----| ----------| ------------| --------|
| 1| 2| 0.1 | 0.01| 2.984875885 | 0.03724869193978667|
| 2 | 2 |0.1 | 0.01| 3.954909155 | 0.0008379486004046104|
| 3 | 2|0.1 | 0.01| 5.385895556 | 3.802469278498239e-5|
| 3 | 2|0.01 | 0.01|12.379664108 | 1.2839211096297455e-9|
| 4 | 2|0.1 | 0.01| 6.155912627 | 2.9870477650254105e-6|
| 5 | 2 |0.1 | 0.01| 7.713675751 | 3.554698556481469e-7 |
| 5 | 2 |0.1 | 0.001|61.49789065 | 3.496044884281843e-7|
| 5 | 2 |0.1 | 0.1|0.894010633 | 0.009269408195040687|



