function TASK1_C_kernel_elimination
% Metoda eliminacji uogólnionej z wykorzystaniem jądra macierzy A
% (implementacja własna wzoru analitycznego na alpha*)

G = [2 0;
     0 1];
t = [-2;
     -1];

A = [1 1];
b = 1;

% Punkt szczególny: A*x_p = b
x_p = [1; 0];

% Wektor z jądra macierzy A (baza przestrzeni zerowej)
z = [1; -1];

% Funkcja jednowymiarowa φ(α) - tylko do weryfikacji/wizualizacji
phi = @(alpha) 0.5 * (x_p + z*alpha)' * G * (x_p + z*alpha) ...
               + t' * (x_p + z*alpha);

% -------------------------------------------------------------
% Wyznaczenie optymalnego kroku alpha ze wzoru analitycznego:
% Rozwiązujemy równanie dφ/dα = 0
% Pochodna ma postać: (z'Gz)*alpha + (z'Gx_p + t'z) = 0
% -------------------------------------------------------------

numerator = z' * G * x_p + t' * z;  % Część liniowa pochodnej
denominator = z' * G * z;           % Część przy alpha (Hessian kierunkowy)

alpha_star = -numerator / denominator;  % <--- IMPLEMENTACJA WZORU

x_star = x_p + z * alpha_star;
f_star = phi(alpha_star);

disp('--- Metoda eliminacji uogólnionej (jądro A) ---')
disp('Punkt optymalny x*:')
disp(x_star)

disp('Wartość funkcji celu f(x*):')
disp(f_star)
end