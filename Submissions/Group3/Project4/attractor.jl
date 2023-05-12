using Plots

function next(x,y,z,dt)
x_=-1.5*x*(1-x^2+y^2)-sqrt(1.5)*y^2*z
y_= 1.5*y*(1+x^2-y^2)+sqrt(1.5)*x*y*z
z_=sqrt(6)*x*(100-z^2)
return [x+x_*dt,y+y_*dt,z+z_*dt]
end

function trajectory(x0,y0,z0)
dt=0.0001
T=0:dt:5

N=length(T)

X=zeros(N)
Y=zeros(N)
Z=zeros(N)


X[1]=x0
Y[1]=y0
Z[1]=z0

for i=1:N-1
X[i+1],Y[i+1],Z[i+1]=next(X[i],Y[i],Z[i],dt)
end
return X,Y,Z
end

function main()
X1,Y1,Z1=trajectory(0.95,0.7,-9)
p=plot(X1,Y1,Z1,gridalpha=1,label="",xlabel="X",ylabel="Y",zlabel="Z",camera=(45,30),ylim=(0,1.2),linewidth=1.5)
scatter!(p,[X1[1]],[Y1[1]],[Z1[1]],label="traj. 1")

X2,Y2,Z2=trajectory(-0.45,0.4,5)
plot!(p,X2,Y2,Z2,label="",linewidth=1.5)
scatter!(p,[X2[1]],[Y2[1]],[Z2[1]],label="traj. 2")

#scatter!([0],[1],[0.5],markersize=5,label="r0")

display(p)
end
@time main()
