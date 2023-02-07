PYL800: Project 1

Group 3
--------

Members:

Monojit Chatterjee       2021PHS7199
Manoj Yadav              2021PHS7196

----------------
The programs in this folder are:

(A) main_progral.jl

This has everything. It contains functions to: 

(1) find area of a discretized function using Simpson's 1/3 Rule.
(2) normalize a given discretized function using the area function above.
(3) Use the method given in the paper to find the table of coefficients. This is then used to form the 2nd derivative operator using 2r+1 point formula. Much more accurate.
(4) Read the data files and retrieve the factors to quickly form the Pade approximant of exp(z). This improves time evolution accuracy.
(5) The main function. This forms a domain, creates a wavefunction in discrete form. Forms the Hamiltonian operator, and uses Pade approximant to form the propagator. Afterwards in a loop, evolves the wavefunction, plots it, saves the image to a file. 

The user can modify: the domain, the step sizes dx and dt, the number of timesteps to find, the wavefunction, the order r of spatial accuracy, order M for temporal accuracy, and the potential (Harmonic and Step fn etc).

-------------------------------------
(B) PadeApproximants.jl

This program, written by Manoj, calculates the factors of the Pade approximant. This is what generated the data files for pre-computed factors.
-------------------------------------

(C) without-factorization.jl

This was my original program (Monojit's) and used 1|1 Pade approximant to evolve. Later it was modified to use higher order Pade approximant directly without finding the factors. This doesn't rely on any external files and is standalone.

-------------------------------------
(D) movie.sh

A simple bash script which can be used to convert the images in the "images" folder into a movie. Modify this to change the framerate.

