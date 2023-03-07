#=
# This program calculates the definite integral of the function defined in the file
# function_def.jl over an interval. The method used for the integration is 
# simpson's 1/3 rule
#
=#
include("initial_data.jl")
delta_t = 0.001

l_lower = -10

l_upper = 10

i = l_lower:delta_t:l_upper  		# limits over which the function needs to be defined

arr_i = collect(i)

let sum = 0
	for k in 1:length(arr_i)
		if k == 1 || k == length(arr_i)
			sum += foo(arr_i[k])
		elseif mod(k,2) == 0
			sum += 2*foo(arr_i[k])
		else
			sum += 4*foo(arr_i[k])
		end
	end

	global integral = (delta_t/3)*sum
	
end
println("The integral of the function over the chosen limits is ==> ", integral)
