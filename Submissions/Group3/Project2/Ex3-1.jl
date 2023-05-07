using Plots
using SpecialFunctions
using Distributions
using CSV
using DataFrames
using LinearAlgebra
df = CSV.read("Manoj.csv", DataFrame, header=false)
#println(df[:,1])
xraw = df[:,1]
yMat = df[:,2]
cRaw = df[:,3]
n= length(cRaw)
xMat = Matrix{Float64}(undef,n,3)
for i in 1:n
    xMat[i,1] = 1
    xMat[i,2] = xraw[i]
    xMat[i,3] = xraw[i] * xraw[i]
end

cMat = Matrix{Float64}(undef,n,n)
for i in 1:n
    for j in 1: n
        cMat[i,j] = 0
        if (i==j)
            cMat[i,j] = cRaw[i]
        end
    end
end
tempMat = xMat'*inv(cMat)

bmMat = inv(tempMat*xMat)*(tempMat*yMat)

println(bmMat)
println(" standard uncertainty variance $(bmMat[1])")
gr()
plot(1,1)
plot(xraw,yMat,seriestype=:scatter, show=true)
f(x) = bmMat[3] * x^2 + bmMat[2] * x + bmMat[1]
xvec = Vector{Float64}()
yvec = Vector{Float64}()
for i in 0:.01:1
    push!(xvec, i)
    push!(yvec, f(i))
end
plot!(xvec, yvec,xlabel="z", ylabel="DM-LSS[pccm^(-3)]")
#Plots.abline!(bmMat[3], bmMat[2],bmMat[1], line=:dash)
readline()