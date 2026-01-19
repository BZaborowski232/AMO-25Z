%% Zadanie 2 (B)
% Rozwiązanie metodą eliminacji zmiennych
% Dwa ograniczenia równościowe – zbiór dopuszczalny jednoelementowy
% (Implementacja poprzez rozwiązanie układu równań liniowych ograniczeń)

clc; clear;

%% Dane zadania
G = [2 0;
     0 1];

t = [-2;
     -1];

% Ograniczenia definiujące punkt (przecięcie prostych)
% Równanie 1: x1 + x2 = 1
% Równanie 2: x1 - x2 = 0
A_eq = [1  1;
        1 -1];

b_eq = [1;
        0];

%% Wyznaczenie punktu (Rozwiązanie układu A*x = b)
% Ponieważ mamy 2 zmienne i 2 niezależne równania,
% punkt dopuszczalny jest tylko jeden.
x_opt = A_eq \ b_eq;  % <--- MATLAB wylicza to: [0.5; 0.5]

%% Wartość funkcji celu
f_opt = 0.5 * x_opt' * G * x_opt + t' * x_opt;

%% Wyniki
disp('Rozwiązanie optymalne x* (z przecięcia ograniczeń):');
disp(x_opt);

disp('Wartość funkcji celu f(x*):');
disp(f_opt);