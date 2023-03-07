using Plots

# Takes a function as input from the user 
println("Enter a function of x: ")
input_function = readline()
input_function = eval(Meta.parse("x -> " * input_function))

# Define range of x
x = range(-10, 10, 200)

y = input_function.(x)

# Plotting 
plot(x, y)
xlabel!("x")
ylabel!("y")
