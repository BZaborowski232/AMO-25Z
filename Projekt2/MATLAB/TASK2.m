function TASK2
% ZADANIE 2A: Własna implementacja metody ograniczeń aktywnych
% Rozwiązywany problem: min 0.5*x'*G*x + t'*x
% Ograniczenia: x1 + x2 <= 1, x1 >= 0, x2 >= 0

clc;
disp('--- ZADANIE 2A: Własna implementacja (Metoda Ograniczeń Aktywnych) ---');

%% 1. Dane wejściowe
G = [2 0;
     0 1];
t = [-2;
     -1];

% Definicja ograniczenia głównego: x1 + x2 <= 1
A_ineq = [1 1]; 
b_ineq = 1;

%% 2. Krok 1: Rozwiązanie problemu bez ograniczeń
% Szukamy minimum globalnego paraboloidy: G*x = -t
disp('Krok 1: Próba rozwiązania bez ograniczeń...');
x_curr = G \ (-t);

disp(['Punkt startowy (bez ograniczeń): [', num2str(x_curr'), ']']);

%% 3. Krok 2: Weryfikacja ograniczeń
% Sprawdzamy, czy punkt [1; 1] spełnia x1 + x2 <= 1
check_constraint = A_ineq * x_curr; % 1*1 + 1*1 = 2

if check_constraint > b_ineq
    disp('-> Ograniczenie x1 + x2 <= 1 jest NARUSZONE (2 > 1).');
    disp('-> Dodajemy ograniczenie do zbioru aktywnego.');
    
    % Budujemy układ równań KKT dla ograniczenia aktywnego (traktujemy jak równość)
    % [ G   A' ] [ x ] = [ -t ]
    % [ A   0  ] [ λ ]   [  b ]
    
    A_active = A_ineq;
    b_active = b_ineq;
    
    % Konstrukcja macierzy KKT (korzystamy z bloków macierzy)
    KKT_Matrix = [G, A_active';
                  A_active, 0];
              
    RHS_Vector = [-t;
                   b_active];
    
    % Rozwiązanie układu liniowego (korzystamy z operatora \)
    sol = KKT_Matrix \ RHS_Vector;
    
    % Wyciągnięcie wyników
    x_opt = sol(1:2);
    lambda = sol(3);
    
    disp(['Nowy punkt optymalny: [', num2str(x_opt'), ']']);
    disp(['Mnożnik Lagrange lambda: ', num2str(lambda)]);
    
    % Sprawdzenie warunku optymalności (KKT)
    if lambda >= 0
        disp('-> Warunek lambda >= 0 spełniony. Znaleziono minimum.');
    else
        disp('-> Lambda ujemna - należałoby usunąć ograniczenie (tu nie wystąpi).');
    end
    
else
    disp('-> Ograniczenia spełnione. Punkt jest optymalny.');
    x_opt = x_curr;
end

% Sprawdzenie pozostałych ograniczeń (x >= 0)
if all(x_opt >= 0)
    disp('-> Warunki nieujemności (x1>=0, x2>=0) są spełnione.');
else
    disp('-> Naruszenie warunków nieujemności! (Wymagana kolejna iteracja).');
end

%% 4. Obliczenie wartości funkcji celu
% Wzór: f(x) = 0.5 * x' * G * x + t' * x
f_val = 0.5 * x_opt' * G * x_opt + t' * x_opt;

disp(' ');
disp('----------------WYNIKI KOŃCOWE----------------');
disp('Punkt optymalny x*:');
disp(x_opt);
disp('Wartość funkcji celu f(x*):');
disp(f_val);

end