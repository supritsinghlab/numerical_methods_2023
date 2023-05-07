using LinearAlgebra
using Plots

#creating sigma_(i) by defing function

function sigma(z)
    sigma_mw=30
    sigma_lss= 40+ z*140
    sigma_host= 50/(1+z)
    return sqrt(sigma_mw^2+sigma_lss^2+sigma_host^2)
end

function Integral(z,h)
    x= range(0,z,length=1000)
    s=x[2]-x[1]
    y=0
    Omega_m= 0.34
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
    y=Chi_e*f_IGM*113.02*300*0.02237*Integral(z,h)/h + 100/(1+z)
    #y=f_IGM*972*Integral(z,h)/h + 100/(1+z)
    return y
end
function L(z,h,DM)
    deviation= DM-DM_theory(z,h)
    y= sqrt(1/2*pi*(sigma(z)^2))*exp(-1*deviation^2/(2*sigma(z)^2))
    return y
end

z_list=[0.19273,0.291,0.3214,0.4755,0.522,0.66]
DM_list=[508,363.6,361.42,589.27,593.1,760.8]
MW_DM=[188,57.3,40.5,102,56.4,37]
DM_final=DM_list - MW_DM./(1 .+z_list)

Nh=1001
h_ar=range(-1,4.1,length=Nh)'
l_d= zeros(length(z_list)+1,Nh)
Cumulative= ones(1,Nh)
for j in collect(1:1:length(z_list))
    for i in collect(1:1:Nh)
        l_d[j,i]=L(z_list[j],h_ar[i],DM_final[j])
        
    end
    global Cumulative
    l_d[j,:]=l_d[j,:]
    Cumulative = Cumulative.*l_d[j,:]'
end
l_d[length(z_list)+1,:]=Cumulative

#Normalize
a,b=findmax(Cumulative)
print("h is ", h_ar[b[2]],"\n\n")
s2=h_ar[2]-h_ar[1]
sum_l= sum(l_d',dims=1)
l_d=l_d./(sum_l'.*s2)


#calculating standard deviation
for j in collect(1:1:length(z_list)+1)
    y1=sqrt(sum((h_ar'.^2).*l_d[j,:]*s2)-sum(s2.*h_ar'.*l_d[j,:])^2)
    print(y1,"\n")
end

#Cumulative Distribution
#plot(h_ar',Cumulative')

plot(h_ar',l_d',xlims=(0.3,1.1))



