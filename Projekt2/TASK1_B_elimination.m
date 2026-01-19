function TASK1_B_elimination
% Rozwiązanie zadania QP metodą eliminacji zmiennych
% (implementacja własna – bez solverów optymalizacyjnych)

% Dane problemu
G = [2 0;
     0 1];
t = [-2;
     -1];

% Ograniczenie równościowe: x1 + x2 = 1
% Eliminacja: x2 = 1 - x1

% Definicja funkcji jednowymiarowej φ(x1)
phi = @(x1) 0.5 * ( ...
    [x1; 1 - x1]' * G * [x1; 1 - x1] ) ...
    + t' * [x1; 1 - x1];

% Pochodna funkcji φ(x1):
% φ(x1) = (3/2)x1^2 - 2x1 - 1/2
% dφ/dx1 = 3x1 - 2

x1_star = 2/3;
x2_star = 1 - x1_star;

x_star = [x1_star; x2_star];
f_star = phi(x1_star);

% Wyświetlenie wyników
disp('--- Metoda eliminacji zmiennych ---')
disp('Punkt optymalny x*:')
disp(x_star)

disp('Wartość funkcji celu f(x*):')
disp(f_star)
end