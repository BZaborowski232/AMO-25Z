function TASK1_A_Lagrange
% Analityczne rozwiązanie zadania QP
% z jednym ograniczeniem równościowym
% z wykorzystaniem mnożników Lagrange’a
% (implementacja własna – bez solverów)

% Dane problemu
G = [2 0;
     0 1];
t = [-2;
     -1];
A = [1 1];
b = 1;

% -------------------------------------------------
% Warunki KKT:
% [ G   A' ] [ x ] = [ -t ]
% [ A    0 ] [ λ ]   [  b ]
% -------------------------------------------------

KKT = [G, A';
       A, 0];

rhs = [-t;
        b];

% Rozwiązanie układu równań liniowych
solution = KKT \ rhs;

% Wyodrębnienie rozwiązania
x_star = solution(1:2);
lambda_star = solution(3);

% Obliczenie wartości funkcji celu
f_star = 0.5 * x_star' * G * x_star + t' * x_star;

% Wyświetlenie wyników
disp('--- Rozwiązanie analityczne (mnożniki Lagrange’a) ---')
disp('Punkt optymalny x*:')
disp(x_star)

disp('Mnożnik Lagrange’a λ*:')
disp(lambda_star)

disp('Wartość funkcji celu f(x*):')
disp(f_star)
end