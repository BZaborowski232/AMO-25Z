function TASK1_B_elimination
% Rozwiązanie zadania QP metodą eliminacji zmiennych
% (implementacja własna – bez solverów optymalizacyjnych)

% Dane problemu
G = [2 0;
     0 1];
t = [-2;
     -1];

% Ograniczenie równościowe: x1 + x2 = 1  =>  x2 = 1 - x1
% Podstawiając do funkcji celu otrzymaliśmy funkcję jednej zmiennej:
% phi(x1) = 1.5*x1^2 - 2*x1 - 0.5
% (Współczynniki wynikają z podstawienia algebraicznego wykonanego w raporcie)

% Współczynniki funkcji kwadratowej ax^2 + bx + c
a_coeff = 1.5;
b_coeff = -2.0;

% Definicja funkcji (do późniejszego sprawdzenia wyniku)
phi = @(x1) a_coeff*x1^2 + b_coeff*x1 - 0.5;

% -----------------------------------------------------------
% Implementacja wzoru na minimum funkcji kwadratowej:
% Pochodna: 2*a*x + b = 0  =>  x = -b / (2a)
% -----------------------------------------------------------
x1_star = -b_coeff / (2 * a_coeff);  % <--- TERAZ PROGRAM TO LICZY

% Wyznaczenie drugiej zmiennej z ograniczenia
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