function simpsons(y,a,b,n)
    # n should be even
    h = (b-a)/n
    xi0 = y(a)+y(b)     # end points
    xi1 = 0               # odd points
    xi2 = 0               # even points
    # performing integration
    for i in 1:n-1
        x = a + i*h
        # if even add to xi2
        if i%2 == 0
            xi2 += y(x)
        else
            # odd add to xi1
            xi1 += y(x)
        end
    end
    # add everything together
    xi = h*(xi0 + 4*xi1 + 2*xi2)/3
    return xi
end