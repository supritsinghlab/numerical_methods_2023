import corner
import matplotlib.pyplot as plt
import numpy as np
import emcee

def area(fn,dx):
    n=len(fn)
    area=fn[0]+fn[n-1]

    for i in np.arange(1,n-2):
        area+= (4-2*(i%2))*fn[i]
    
    area=dx*(area)/3
    return area

def intg(h,omega_m_h_sq,zmax):
    A=np.zeros(len(zmax))
    for i in range(len(zmax)):
        z=np.arange(0,zmax[i],0.01)
        A[i]=area((1+z)/np.sqrt(omega_m_h_sq*(1+z)**3 + h*h-omega_m_h_sq),0.01)
    return A

N=200

my_data = np.genfromtxt('output.csv', delimiter=',')
z=my_data[0:N,0]
DM=my_data[0:N,1]


def log_likelihood(theta, z, DM):
    h,omega_m_h_sq, num = theta
    model = num/(1+z) + 557.34*intg(h,omega_m_h_sq,z)
    sigma2=50/(1+z) + 30+ (40+140*z)
    
    return -0.5 * np.sum((DM - model) ** 2 / sigma2 + np.log(sigma2))

def log_prior(theta):
    #print(theta)
    h,omega_m_h_sq , num = theta
    if 0.01 < omega_m_h_sq < 0.3 and 0.5 < h < 0.8 and 80 < num < 120:
        return 0.0
    return -np.inf

def log_probability(theta, z, DM):
    lp = log_prior(theta)
    if not np.isfinite(lp):
        return -np.inf
    return lp + log_likelihood(theta, z, DM)



pos = np.array([0.629,0.143,100]) + 1e-1*np.random.randn(N, 3)
nwalkers, ndim = pos.shape

sampler = emcee.EnsembleSampler(nwalkers, ndim, log_probability,args=(z,DM))
sampler.run_mcmc(pos,100)
flat_samples = sampler.get_chain(discard=50, thin=15, flat=True)
fig=corner.corner(flat_samples,bins=80,labels=["h","Ω_m*h^2","<DM_host>"])
fig.show()



















