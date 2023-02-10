#finding coefficinets for differetial matrix

#no. of points to use odd one
for m in collect(3:2:11)
    k=(m-1)/2
    M=zeros(m,m)
    #constructing mxm matrix
    k1 = -1*k
    for i in collect(1:1:m)
        for j in collect(1:1:m)
            j1=j-1
            M[i,j]= (k1)^j1/(factorial(j1))

        end
        k1=k1+1
    end
    print((round.(inv(M)[3,:],digits=8)))
    print("\n")
end