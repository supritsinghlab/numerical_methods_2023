using Polynomials
using TaylorSeries
using DelimitedFiles

function GeneratePadeMatrix(nOrder, dOrder,taylorCoeffs)
    numVector = zeros(nOrder+dOrder,1)
    numVector[1] = 1
    comMatrix = numVector
    for i in 2:nOrder
        numVector = circshift(numVector,1)
        comMatrix = hcat(comMatrix,numVector)
    end
    taylorCoeffs = taylorCoeffs * (-1)
    for i in 1:dOrder
        comMatrix = hcat(comMatrix,taylorCoeffs)
        taylorCoeffs = circshift(taylorCoeffs,1)
        taylorCoeffs[1] = 0
    end
    return comMatrix
end

function GetPadeApproximantCoefficients(nOrder, dOrder)
    expTaylor = taylor_expand(exp, 0, order=(nOrder+dOrder))
    taylorCoeffs = Array{Float64}(undef,nOrder+dOrder+1)
    for i in 0:nOrder+dOrder
        taylorCoeffs[i+1] = getcoeff(expTaylor, i)
    end
    return inv(GeneratePadeMatrix(nOrder, dOrder,taylorCoeffs[1:nOrder+dOrder])) * 
           (circshift(taylorCoeffs,-1)[1:nOrder+dOrder])
end

function GetPadeApproximantRoots(nOrder, dOrder)
    padeCoffiecients = GetPadeApproximantCoefficients(nOrder, dOrder)
    return vcat(roots(Polynomial(vcat([1],padeCoffiecients[1:nOrder]))),
           roots(Polynomial(vcat([1],padeCoffiecients[nOrder+1:nOrder+dOrder]))))
end
function GetPadeApproximantRootsFiles(nOrder, dOrder, folderPath)
    readData = readlines("$(folderPath)\\PadeApproxRootsNumOrder$(nOrder).csv")
    vecTemp = split(readData[dOrder], ",")
    vecTempComplex = Vector{ComplexF64}()
    for i in vecTemp
        push!(vecTempComplex, parse(ComplexF64, i))
    end
    return vecTempComplex
end


###Generate the data files containing the factors. Can generate N|M approximant also.
function CreatePadeApproximantFiles()
    for i in 1:10 
        io = open("PadeApproxRootsNumOrder$(i).csv", "a") 
        for j in 1:10
            temp = GetPadeApproximantRoots(i,j)
            writedlm(io,temp',",")
        end
        close(io)
    end
end
#myroots = GetPadeApproximantRootsFiles(10,10,"C:\\Users\\Manoj Yadav\\Desktop\\temp\\papprox")## using files
#myroots = GetPadeApproximantRoots(3,1) ## direct access
#myNumeratorRoots= myroots[1:numeratorOrder]## geting numerator roots
#myNumeratorRoots[2]## e.g 2nd root of numerator
#myDenominatorRoots = myroots[numeratorOrder+1:numeratorOrder+denominatorOrder]## geting denominator roots
#myDenominatorRoots[2]## e.g 2nd root of denominator
