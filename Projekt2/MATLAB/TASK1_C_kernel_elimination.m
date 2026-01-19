function TASK1_C_kernel_elimination
% Metoda eliminacji uogólnionej z wykorzystaniem jądra macierzy A

G = [2 0;
     0 1];
t = [-2;
     -1];

A = [1 1];
b = 1;

% Punkt szczególny: A*x_p = b
x_p = [1; 0];

% Wektor z jądra macierzy A
z = [1; -1];

% Funkcja jednowymiarowa φ(α)
phi = @(alpha) 0.5 * (x_p + z*alpha)' * G * (x_p + z*alpha) ...
               + t' * (x_p + z*alpha);

% Minimum analityczne: 3α + 1 = 0
alpha_star = -1/3;

x_star = x_p + z * alpha_star;
f_star = phi(alpha_star);

disp('--- Metoda eliminacji uogólnionej (jądro A) ---')
disp('Punkt optymalny x*:')
disp(x_star)

disp('Wartość funkcji celu f(x*):')
disp(f_star)
end