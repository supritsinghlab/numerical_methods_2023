using Plots

function velo(x,y)
return [-x*(1-x+3*y),(3+x-3*y)*y]
end

function trajectory(x0,y0)
dt=0.000001
T=0:dt:10

N=length(T)

X=zeros(N)
Y=zeros(N)


X[1]=x0
Y[1]=y0

for i=1:N-1
X[i+1],Y[i+1]=[X[i],Y[i]] .+ dt.*velo(X[i],Y[i])
end
return X,Y
end


function main()
X=0:0.05:1
Y=0:0.05:1



#data=[v(x,y) for (x,y) in zip(X,Y)] #this is why I love Julia

#U=[data[i][1] for i=1:length(data)] #this is why I hate Julia. Can't convert this to 11x2 matrix nicely.
#V=[data[i][2] for i=1:length(data)]
N=length(X)*length(Y)
xpts=zeros(N)
ypts=zeros(N)
U=zeros(N)
V=zeros(N)

i=1
for x in X
for y in Y
if (x,y) in [(0,0),(0,1),(1,0),(1,1)]
continue
end

u,v=velo(x,y)
xpts[i]=x
ypts[i]=y
U[i]=u/sqrt(u^2+v^2) #only unit vector
V[i]=v/sqrt(u^2+v^2)
i+=1
end
end

#Umax=maximum(abs.(U))
#Vmax=maximum(abs.(V))
#M=maximum([Umax,Vmax])

#U=U/Umax
#V=V/Vmax
#println(xpts)
#println(ypts)

q=quiver(xpts,ypts,quiver=(U.*0.04,V.*0.04),linecolor=:red)
scatter!(q,[0,0,1],[0,1,0],label="",markersize=10,markercolor=:green)
scatter!(q,[0,0,1],[0,1,0],label="",markersize=9,markercolor=:white)

#######Trajectories###############
Xtraj,Ytraj=trajectory(0.999,0.001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:black)
Xtraj,Ytraj=trajectory(0.990,0.000005)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:blue)
Xtraj,Ytraj=trajectory(0.990,0.0000001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:red)
Xtraj,Ytraj=trajectory(0.990,0.00000001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:blue)
Xtraj,Ytraj=trajectory(0.990,0.000000001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:black)
Xtraj,Ytraj=trajectory(0.990,0.0000000001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:red)
Xtraj,Ytraj=trajectory(0.990,0.00000000001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:blue)
Xtraj,Ytraj=trajectory(0.990,0.00000000000001)
plot!(q,Xtraj,Ytraj,linewidth=2,label="",linecolor=:black,xlabel="x(t)",ylabel="y(t)")



display(q)
end
@time main()
