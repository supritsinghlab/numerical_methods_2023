using Plots
using SpecialFunctions
using Distributions
using CSV
using DataFrames
using LinearAlgebra
#f(x) = exp(-7*x)*((-(x^2)/7)-(2*x/49)-2/343) + 2/343
println("starting")
f(x) = 17.561445437933507393643042621872 * (x^2)*exp(-7*x)
xvec = Vector{Float64}()
yvec = Vector{Float64}()
for i in 0:.0001:1
    push!(xvec,i)
    sum =0
    for j in 0:.0001:i
       sum = sum +  f(j)
    end
    push!(yvec,sum)
end
#xs = range(0,5,length=50)
zsamples = Vector{Float64}()
for i in 1:500
    ranVar = rand(yvec)
    xvaluePos = findall( x -> x == ranVar,yvec)
    push!(zsamples, xvec[xvaluePos[1]][1])
end
#println(zsamples)
g(x) = 1035.768* x^2 + 61.76 * x + 126.53 ## these numbers comes by solving excersice 3
milkyWay = CSV.read("milkywaydata.csv", DataFrame, header=false)
numberOfSamples = 500
samples = Matrix{Any}(undef,numberOfSamples,3)
for i in 1:numberOfSamples
    samples[i,1] = zsamples[i]
    samples[i,2] = g(zsamples[i])
    samples[i,3] = rand(milkyWay[:,1])
end
CSV.write("samples.csv",  Tables.table(samples), writeheader=false)
println("done")
readline()