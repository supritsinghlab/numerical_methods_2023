using DelimitedFiles
using Plots

function area(fn,dx)#using Simpson's 1/3 rule
n=length(fn)
area=fn[1]+fn[n]

for i=2:n-1
area+= (4-2*(i%2))*fn[i]
end
area=dx*(area)/3
return area
end



#-----------------------------------------------------------------------------------------




function DM_LSS_SI(h,Zmax)

c=3e8
G=6.6743e-11
Omega_b_h_sq=0.022
Omega_m_h_sq=0.143

Xe=0.88
fIGM=0.84
mp=1.67e-27


#output is in the units of pc/cm^3
dz=0.0001
z=0:dz:Zmax

arr= @. (1+z)/sqrt(Omega_m_h_sq*(1+z)^3 + h^2-Omega_m_h_sq)
intg=area(arr,dz)




coeff=3*c*Omega_b_h_sq*Xe*fIGM*3.2404e-18/(8*pi*G*mp)
#print("first stuff is: ")
#display(3*c*Omega_b*0.7*.324078e-17*Xe*fIGM*intg*3.24e-23/(8*pi*G*mp))

return coeff*intg*3.24e-23 #to convert to pc/cm^3
end



#-----------------------------------------------------------------------------------------



function DM_LSS(h,Zmax) ##my calculation on paper.
Omega_m_h_sq=0.143#.143(main paper) or .315(other paper) or .29(website https://ned.ipac.caltech.edu/level5/Sept02/Roos/Roos6.html)
#output is in the units of pc/cm^3

dz=0.0001
z=0:dz:Zmax

arr= @. (1+z)/sqrt(Omega_m_h_sq*(1+z)^3 + h^2-Omega_m_h_sq)
intg=area(arr,dz)

return 557.34*intg #to convert to pc/cm^3
end

#-----------------------------------------------------------------------------------------



function main()
dh=0.001
h=0:dh:2

#Z=[0.0337,0.1178,0.19273,0.291,0.3214,0.378,0.4755,0.522,0.66]
#DM=[348.8,338.7,558.3,363.6,361.4,321.4,504.3,593.1,760.8]
#MWDM=[199,37.2,188,57.3,40.5,57.8,102,56.4,37]

Z=[0.19273,0.291,0.3214,0.4755,0.522,0.66]
DM=[558.3,363.6,361.4,504.3,593.1,760.8]
MWDM=[188,57.3,40.5,102,56.4,37]


LIKELI=ones(length(h))

p=plot() #empty plot object

for i=1:6
z=Z[i]
lss(h)=DM_LSS(h,z)
tot=DM[i]
mw=MWDM[i]/(1+z)

host=100/(1+z) #mean value
#println("tot:",tot," mw:",mw," host: ",host)


sig_lss=40+140*z #in pc/cm^3
sig_mw=30
sig_host=50/(1+z) #in pc/cm^3
sig=sqrt(sig_lss^2+sig_mw^2+sig_host^2)
#println(sig)
L(h) = exp(-(tot-mw-host-lss(h))^2/(2*sig^2))/sqrt(2*pi*sig^2)
#println(lss(0.63))
l=@. L(h)
plot!(p,h,l/area(l,dh),label=string(z))
LIKELI=LIKELI.* @. L(h)
end
plot!(p,h,LIKELI/area(LIKELI,dh),linewidth=4,label="joint",xlim=(0,2))

display(p)
#mean=sum(h.*LIKELI/area(LIKELI,dh))/length(h)
#println("mean is ",mean)
println(argmax(LIKELI)*dh)
end

@time main()
