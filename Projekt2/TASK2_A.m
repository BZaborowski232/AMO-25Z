%% Zadanie 2 (A)
% Rozwiązanie analityczne z wykorzystaniem mnożników Lagrange’a
% Dwa ograniczenia równościowe

clc; clear;

%% Dane zadania
G = [2 0;
     0 1];

t = [-2;
     -1];

A = [1  1;
     1 -1];

b = [1;
     0];

%% Układ KKT
% [ G   A' ] [ x ] = [ -t ]
% [ A    0 ] [ λ ]   [  b ]

KKT = [G, A';
       A, zeros(2)];

rhs = [-t;
        b];

%% Rozwiązanie układu
solution = KKT \ rhs;

x_opt = solution(1:2);
lambda_opt = solution(3:4);

%% Wartość funkcji celu
f_opt = 0.5 * x_opt' * G * x_opt + t' * x_opt;

%% Wyniki
disp('Rozwiązanie optymalne x*:');
disp(x_opt);

disp('Mnożniki Lagrange’a λ*:');
disp(lambda_opt);

disp('Wartość funkcji celu f(x*):');
disp(f_opt);