#ASSIGNMENT 1
#GROUP 7; Pawan Goswami, 2019PH10645 ;
#Shubham Basera, 2021PHS7223

#PROBLEM 7
#Write a Julia Snippet which includes a user defined function, call it "initial_data.jl" to define a function on a domain
#                                             x ϵ [-10,10]
#and generates a plot of the same.

# Importing necessary libraries
using Plots
using LaTeXStrings

function run()
# Defining initial function 
function initial_data(x)
    return exp(-x^2)
end

l = 10    # Defining range of x
dx = 0.01 # Defining step size

x = collect(-l:dx:l) # x data
y = initial_data.(x);

# Plotting data 
p = plot(x, y, title="Gaussian Function", linewidth=3,label = L"\Psi")
xlabel!(L"x")
ylabel!(L"\Psi (x)")
display(p)

end
@time run()