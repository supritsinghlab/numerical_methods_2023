import numpy as np
from numpy.linalg import inv
import matplotlib.pyplot as plt
import scipy.optimize as opt
X = np.array([201, 244, 47, 287, 203, 58, 210, 202, 198, 158, 165, 201, 157, 131, 166, 160, 186, 125, 218, 146], dtype = float)
Y = np.array([592, 401, 583, 402, 495, 173, 479, 504, 510, 416, 393, 442, 317, 311, 400, 337, 423, 334, 533, 344], dtype = float)
sigma_Y = np.array([61, 25, 38, 15, 21, 15, 27, 14, 30, 16, 14, 25, 52, 16, 34, 31, 42, 26, 16, 22], dtype = float)
sigma_X = np.array([9, 4, 11, 7, 5, 9, 4, 4, 11, 7, 5, 5, 5, 6, 6, 5, 9, 8, 6, 5], dtype = float)
rho_XY = np.array([-0.84, 0.31, 0.64, -0.27, -0.33, 0.67, -0.02, -0.05, -0.84, -0.69, 0.30, -0.46, -0.03, 0.50, 0.73, -0.52, 0.90, 0.40, -0.78, -0.56], dtype = float)

def likelihood(x, y, sigma, b, m, Pb = 0.0, Yb = 0.0, Vb = 0.0):
  return np.prod( (1-Pb)* 1/np.sqrt(2*np.pi*sigma**2)        * np.exp(-(y-m*x-b)**2/(2*sigma**2))
                 + Pb   * 1/np.sqrt(2*np.pi*(Vb + sigma**2)) * np.exp(-(y-Yb)**2   /(2*(Vb + sigma**2))))
				 
def log_likelihood(x, y, sigma, b, m, Pb = 0.0, Yb = 0.0, Vb = 0.0):
  return np.sum( np.log( (1-Pb)* 1/np.sqrt(2*np.pi*sigma**2)        * np.exp(-(y-m*x-b)**2/(2*sigma**2))
                        + Pb   * 1/np.sqrt(2*np.pi*(Vb + sigma**2)) * np.exp(-(y-Yb)**2/(2*(Vb + sigma**2)))))

b = 40.0
m = 2.2
np.testing.assert_almost_equal(np.exp(log_likelihood(X, Y, sigma_Y, b, m)), likelihood(X, Y, sigma_Y, b, m))

b = np.linspace(-125.0, +125.0, 100)
m = np.linspace(1.5, 3.1, 100)

L = np.ndarray((len(m), len(b)))
for i in range(len(m)):
  for j in range(len(b)):
    L[i,j] = log_likelihood(X[4:], Y[4:], sigma_Y[4:], b[j], m[i])

plt.contour(b, m, L, 100)

x0 = np.array([40.0, 2.2])
res = opt.minimize(lambda x: -log_likelihood(X[4:], Y[4:], sigma_Y[4:], x[0], x[1]), x0)
plt.plot(res.x[0], res.x[1], 'o')
plt.xlabel("b"); 
plt.ylabel("m");
plt.show()
#print("b + m x = (%f +/- %f) + (%f +/- %f) x" % (res.x[0], '?'), (res.x[1], '?'))
print("chi^2(b = %f, m = %f) = %f" % (res.x[0], res.x[1], res.fun))