PYL800: Project 1

Group 3
--------

Members:

Monojit Chatterjee       2021PHS7199
Manoj Yadav              2021PHS7196

----------------
The idea of the project is to use astronomical data like: Dispersion measure, and Observed redshift(z), from which DM_Milky was has been calculated; and find the Hubble constant H0.
This has been done by approximating DM_host by a Gaussian, with known mean, and using a formula of DM_LSS which is implicitly dependent on H0.

We use a Likelihood function, and plot individual likelihoods, and the mulitply them to obtain the combined likelihood. Whose maximum gave us h (or H0, equivalently). Using only gold sample, we obtain h=0.629.

Then, we generate 500 z from the z^2exp(-7z) distribution. Plot that. We then use the previously found h, to generate DM_tot (w/o DM_MW part) for each z.
From this mock data, we use the Likelihood function, and run MCMC with 500 walkers. The parameter space comprises of omega_m*h^2, h, and the numerator of the <DM_host>. This is plotted too.
