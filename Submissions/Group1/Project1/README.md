# Project 1
* final_project.jl --- main program for time evolution of free particle

* Harmonic.jl --- it is program to calculate time evolution of coherent state in Harmonic potential

* coefficients.jl --- program to compute coefficients
* integrate.jl --- this program defines \, plot and integrate a function



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

## Testing the code
for different values of r for same M for T = 20, l= 50 

|    r    |M | delta x | delta t      | Computation time in s| error |
|  --------|----------| -----| ----------| ------------| --------|
| 1| 2| 0.1 | 0.01| 2.984875885 | 0.0372|
| 2 | 2 |0.1 | 0.01| 3.954909155 | 0.0008|
| 3 | 2|0.1 | 0.01| 5.385895556 | 3.8e-5|
| 3 | 2|0.01 | 0.01|12.379664108 | 1.2e-9|
| 4 | 2|0.1 | 0.01| 6.155912627 | 2.9e-6|
| 5 | 2 |0.1 | 0.01| 7.713675751 | 3.5e-7 |
| 5 | 2 |0.1 | 0.001|61.49789065 | 3.43e-7|
| 5 | 2 |0.1 | 0.1|0.894010633 | 0.009|



## error analysis for coherent state
|    r    |M | delta x | delta t      | Computation time in s| error |
|  --------|----------| -----| ----------| ------------| --------|
| 5| 5| 0.01 | 2pi/500| 93.690489384 | 2.5e-9|
| 5| 5| 0.01 | 2pi/250| 51.018777372 | 6.9e-7|
| 4| 5| 0.01 | 2pi/250| 38.687640955 | 1.9e-6 |

