include("./initial_data.jl")

# stepSize = 0.01
# println(x)
# sum=0

# for i in 

function integrate(startx, endx, stepSize)
    sum = 0
    invert = 1
    if(endx<startx)
        temp = endx
        endx = startx
        startx = temp
        invert = -1
    end
    # x = range(-10,10,step=stepSize)
    maxRange = (endx-startx)/stepSize
    for i in 0:maxRange
        xn = startx+(i*stepSize)
        if (i==0 || i==maxRange)
            sum = sum+myFunction(xn)
        elseif(mod(i,2)==1)
            sum = sum+(4*myFunction(xn))
        elseif(mod(i,2)==0)
            sum = sum+(2*myFunction(xn))
        end
    end
    return (invert*sum*stepSize/3)

end

x = range(-10,10,step = 0.001)
y = Vector{Float64}()
# print(integrate(0,-10,0.1))
for i in eachindex(x)
    push!(y,integrate(0,x[i],0.001))
end
plot!(x,y)