footer: Department of Physics, IIT DELHI | Winter Semester 2022-2023
slidenumbers: true

# PYL800: Numerical and Computational Methods in Research 

### Course instructor: Suprit Singh

---

# Course Outline 

1. Role of Numerical & Computational Techniques

2. Working Environment -- GNU/Linux, Julia ...

3. Numerical Techniques involved in solving Physics problems 

4. 8-10 Projects for you to work on

5. Data handling, interpretation, analysis, and Visualization

6. Git management, Markdown, Presentation, LaTeX
   
---

# _*Projects*_

* [physics/0701150] Accurate numerical solutions of the time-dependent Schrödinger equation

* [1701.08137] Numerical solutions of the time-dependent Schrodinger equation in two dimensions

* [1705.01510] Deformation of horizons during a merger

* [2104.04538] A new measurement of the Hubble constant using Fast Radio Bursts

---

* [1707.01060] QuantumOptics.jl: A Julia framework for simulating open quantum systems

* [1402.2405] The influence of primordial magnetic fields on the spherical collapse model in cosmology

* [astro-ph/9406050] A Two-Fluid Approximation for Calculating the Cosmic Microwave Background Anisotropies

* A pedagogical model of primordial helium synthesis

* [1703.09598] Caustic Skeleton & Cosmic Web

* [2010.03089] Multi-plane lensing in wave optics 

---

# _Evaluation_

1. Continuous with weightage of 50 Marks

2. Assignments x 2 with weightage of 10 Marks

3. Minor Exam x 2 with weightage of 20 marks

4. Major Exam x 1 with a weightage of 20 marks 


---

# Role of Numerical & Computational Methods

- Physics: an endeavour to explain what we observe!

- Observations $$\implies$$ Data: structuring, visualisation, and interpretation   

- Data $$\implies$$ Fixing parameters in our models, often statistically, test principles  

- Models $$\implies$$ Predictions: Semi-analytical, Numerical, and Simulations 
  
- Cycle repeats ad infinitum (?) 

---

# Thinking about equations - I

- Models are described by Equations, which in turn are made up of variables

- Physical variables have dimensions such as d, distance has dimensions of Length

- Dimensionless numbers, eg., $$\pi$$

- Dimensionless quantities that still carry units eg., angle $$\theta$$ 

- But, a computer understands equations and vars as dimensionless 

---

- $$y(t) = y_0 + v_0 t + \frac{1}{2} gt^2$$ or $$y(t)=3+2t-5t^2$$ 

- Certain functions are transcendental eg.,

$$
\begin{align}
\sin u = u - \frac{u^3}{6} + \frac{u^5}{120} + \frac{u^7}{5040} + \cdots  
\end{align}
$$

- Validity requires arguments to be dimensionless!

$$
\begin{align}
f(t) = \exp \lambda t = 1 + \lambda t + \frac{(\lambda t)^2}{2} + \cdots  
\end{align}
$$

- Define $$x:=\lambda t$$ and $$\lambda$$ defines a scale

---

# Linux Commands

[.hide-footer]

![](linux_commands.png)

---



If you really must tweak line breaks, you can use the `<br/>` tag to split any line of text.
