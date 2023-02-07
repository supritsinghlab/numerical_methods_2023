include("initial_data.jl")
function integrate(f,a,b)          #Simpson integration for vector function
    n=length(f)-1
    h=(b-a)/n
    I= h/3*(f[1]+2*sum(f[3:2:end-2])+4*sum(f[2:2:end])+f[end])
    return I
end

iwf=integrate(wf,-10,10)                    #Integrate the wavefunction
println(iwf)