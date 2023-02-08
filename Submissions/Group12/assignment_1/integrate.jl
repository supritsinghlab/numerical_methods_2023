include("initial_data.jl")

# Define the integration limits and step size
a = -10
b = 10
step_size = 0.1

# Method 1: Mid-point Rule
integral_midpoint = 0.0
for x in a:step_size:b
    global integral_midpoint += input_function(x) * step_size
end

# Method 2: Simpson's Rule
integral_simpson = 0.0
n = div(b-a,step_size)
for i in range(start=1,stop=n-1,step=2)
    x = a + i*step_size
    global integral_simpson += (input_function(x-step_size) + 4*input_function(x) + input_function(x+step_size))
end
integral_simpson *= step_size/3

println("Integral using Mid-point Rule is: ", integral_midpoint)
println("Integral using  Simpson's Rule is: ", integral_simpson)
println("Difference between integrals by the two methods is: ",abs(integral_midpoint - integral_simpson))
println("Error: ", abs((integral_midpoint-integral_simpson)/(integral_simpson)), " %")
