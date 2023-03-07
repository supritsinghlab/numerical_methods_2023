#ASSIGNMENT 1
#GROUP 7; Pawan Goswami, 2019PH10645 ;
#Shubham Basera, 2021PHS7223

#PROBLEM 8

#Write a Julia Snippet which takes the function defined in the "initial_data.jl" #and integrates it on the domain x ϵ [-10,10]

function run()

# Defining initial function 
function initial_data(x)
    return exp(-x^2)
end

# Integrating Using Simpson Method
function Simpson(func,A, B ,N)
    h   = (B − A) / (N − 1) # step size
    sum = ( func(A)+ func(B) ) 
    
    for i = 1:2:N-1
        sum += 4*func(A+i *h)
    end
    
    for i = 2:2:N-2
        sum += 2*func(A+i *h)
    end
return h*sum/3
end

A = -l
B =  l
N = 1001

int =Simpson(initial_data,A, B ,N);
print("The integral is " *string(int))

end
@time run()
