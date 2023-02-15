function Time_Evolution_Matrix(potential_vals; r=2, z_s = -2, dt=dt, dx=dx, m=m, hbar=hbar)

    b = (im * hbar * dt) / (2 * m * (dx)^2)
    
    cn_coeffs = coeff_2kth_derivative(r)
    
    a_ks = (b / z_s) * cn_coeffs
    
    spatial_samples = length(potential_vals)
    
    d_js = (1 + a_ks[begin]) * ones(spatial_samples) - potential_vals * (im * dt / hbar) / z_s
    


    I = [i for i = 1:spatial_samples]
    
    J = [j for j = 1:spatial_samples]
   
    S = d_js
    
    for k = 1:r
        
        upper_tri_i = [i for i = 1:spatial_samples-k]
        upper_tri_j = [i + k for i = 1:spatial_samples-k]
        
        

        I = vcat(I, upper_tri_i, upper_tri_j)
        J = vcat(J, upper_tri_j, upper_tri_i)


        S = vcat(S, a_ks[k+1] * ones(2 * (spatial_samples - k)))
    end
    

    A = Matrix(sparse(I, J, S))

    return inv(A) * conj.(A)
end