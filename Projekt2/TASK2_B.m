%% Zadanie 2 (B)
% Rozwiązanie metodą eliminacji zmiennych
% Dwa ograniczenia równościowe – zbiór dopuszczalny jednoelementowy

clc; clear;

%% Dane zadania
G = [2 0;
     0 1];

t = [-2;
     -1];

%% Eliminacja zmiennych z ograniczeń
% x1 + x2 = 1
% x1 - x2 = 0  ->  x1 = x2

x1 = 1/2;
x2 = 1/2;

x_opt = [x1;
         x2];

%% Wartość funkcji celu
f_opt = 0.5 * x_opt' * G * x_opt + t' * x_opt;

%% Wyniki
disp('Rozwiązanie optymalne x*:');
disp(x_opt);

disp('Wartość funkcji celu f(x*):');
disp(f_opt);