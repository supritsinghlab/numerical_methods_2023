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



