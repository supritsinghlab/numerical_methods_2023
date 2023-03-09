using LinearAlgebra
using Plots

#creating sigma_(i) by defing function

function sigma(z)
    sigma_mw=30
    sigma_lss= 40+ z*140
    sigma_host= 50/(1+z)
    return sqrt(sigma_mw^2+sigma_lss^2+sigma_host^2)
end

function Integral(z)
    x= range(0,z,length=1000)
    s=x[2]-x[1]
    y=0
    Omega_m= 0.143
    Omega_l= 1-Omega_m
    for i in collect(1:1:1000)
        y=y+ (1+x[i])*s/(sqrt(Omega_m*(1+x[i])^3+Omega_l))
    end
    return y 
end

function DM_theory(z,h)
    # Chi_e = 0.88
    #f_IGM = 0.84
    Chi_e= 0.88
    f_IGM=0.84
    y=Chi_e*f_IGM*113.02*300*0.02237*Integral(z)/h + 100/(1+z)
    return y
end
function L(z,h,DM)
    deviation= DM-DM_theory(z,h)
    y= sqrt(1/2*pi*(sigma(z)^2))*exp(-1*deviation^2/(2*sigma(z)^2))
    return y
end

z_list=[0.0337,0.1178,0.19273,0.291,0.3214,0.378,0.4755,0.522,0.66]
DM_list=[348.8,338.7,558,363.6,361.42,321.4,589.27,593.1,760.8]

Nh=40
h_ar=range(0,1,length=Nh)
l_d= zeros(length(z_list),Nh)
for j in collect(1:1:5)
    for i in collect(1:1:Nh)
        l_d[j,i]=L(z_list[j],h_ar[i],DM_list[j])
    end
    plot!(h_ar',l_d[j,:]')
    print("hhhh")
end






