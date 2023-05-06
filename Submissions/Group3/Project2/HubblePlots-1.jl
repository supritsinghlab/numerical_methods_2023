#import Pkg
#Pkg.add("DataFrames")
using Plots
using SpecialFunctions
using Distributions
using CSV
using DataFrames
using LinearAlgebra

function myFunc(x, mu, sigma)
    return (1 / (2 * 3.14 * sigma)^0.5) * exp(-(x - mu)^2 / (2 * (sigma^2)))
end
df = CSV.read("datahubble.csv", DataFrame, header=false)
println(df)
println(df[2, 2])
mu = 0
sigma = 1
vecofvec = Vector{Vector{Float64}}()

xvec = Vector{Float64}()
function generateFunc(mu, sigma)
    vec = Vector{Float64}()
    for x = -100:5:300
        push!(vec, myFunc(x, mu, sigma))
    end
    push!(vecofvec, normalize(vec))
end
for x = -100:5:300
    push!(xvec, x)
end

for i in 1:9
    generateFunc(df[i, 1], df[i, 2])
end
gr()
#plot.xlims!(-10, 10)
plot(1, 1)
vectTemp = Vector{Float64}()

for x in 1:length(xvec)

    temp = 1
    for i in 1:9
        temp = temp * vecofvec[i][x]
    end
    push!(vectTemp, temp)

end
push!(vecofvec, normalize(vectTemp))
display(plot(xvec, vecofvec, xlabel="H0 [km s−1 Mpc−1]", ylabel="probability density", labels=false))
readline()