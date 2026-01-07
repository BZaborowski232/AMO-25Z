# Viz_TASK1.py
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Dane problemu
G = np.array([[2, 0],
              [0, 1]])
t = np.array([-2, -1])
A = np.array([[1, 1]])
b = 1

# Funkcja celu
def f(x):
    return 0.5 * x.T @ G @ x + t.T @ x

# Tworzymy siatkę punktów dla wykresu
x1 = np.linspace(-0.5, 1.5, 100)
x2 = np.linspace(-0.5, 1.5, 100)
X1, X2 = np.meshgrid(x1, x2)
F = np.zeros_like(X1)

for i in range(X1.shape[0]):
    for j in range(X1.shape[1]):
        x_vec = np.array([X1[i,j], X2[i,j]])
        F[i,j] = f(x_vec)

# Punkt optymalny
x_star = np.array([2/3, 1/3])
f_star = f(x_star)

# ------------------ Wykres 3D ------------------
fig = plt.figure(figsize=(10, 5))
ax = fig.add_subplot(121, projection='3d')
ax.plot_surface(X1, X2, F, cmap='viridis', alpha=0.8)
ax.scatter(x_star[0], x_star[1], f_star, color='r', s=50, label='x*')
ax.set_xlabel('$x_1$')
ax.set_ylabel('$x_2$')
ax.set_zlabel('$f(x)$')
ax.set_title('Funkcja celu 3D')
ax.view_init(elev=30, azim=120)
ax.legend()

# ------------------ Wykres konturowy ------------------
ax2 = fig.add_subplot(122)
contours = ax2.contour(X1, X2, F, levels=30, cmap='viridis')
ax2.clabel(contours, inline=True, fontsize=8)
ax2.plot(x_star[0], x_star[1], 'ro', label='x*')

# Ograniczenie równościowe x1 + x2 = b
x1_line = np.linspace(-0.5, 1.5, 100)
x2_line = b - x1_line
ax2.plot(x1_line, x2_line, 'r--', label='Ograniczenie x1+x2=1')

ax2.set_xlabel('$x_1$')
ax2.set_ylabel('$x_2$')
ax2.set_title('Poziomice funkcji celu z ograniczeniem')
ax2.legend()

plt.tight_layout()
plt.show()