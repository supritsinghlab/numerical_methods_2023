using Plots
l=10
x=range(-1*l,l,length=501)
h=x[2]-x[1]
y=[exp.(-1*x.*x)]
y1=exp.(-1*x.*x)
integral1 =0.0
for i in collect(1:1:length(x))
    integral1=integral1+y1[i]
end
integral1=integral1*h
d1=0.0
d2=0.0
for i in collect(1:2:length(x))
        global d1
        d1=d1+y1[i]
end
for i in collect(2:2:length(x))
        global d2
        d2=d2+y1[i]
end
integral2=(y1[1]+y1[end]+2*d1+4*d2)*h/3
print(integral1)
print("\n")
print(integral2)
print("\n")
print(sqrt(pi))
plot(x,y)