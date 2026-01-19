%% Zadanie 2 (C)
% Metoda eliminacji uogólnionej z wykorzystaniem jądra macierzy A

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

%% Punkt szczególny Ax = b
xp = [1/2;
      1/2];

%% Wektor bazy jądra A (Az = 0)
z = [1;
    -1];

%% Funkcja jednowymiarowa phi(alpha) w postaci ogólnej
% x(alpha) = xp + z*alpha
phi = @(alpha) 0.5*(xp + z*alpha)'*G*(xp + z*alpha) + t'*(xp + z*alpha);

%% Warunek konieczny minimum
dphi = @(alpha) (z'*G*(xp + z*0.0) + t'*z);  % pochodna dla alpha = 0
alpha_star = 0; 

%% Punkt optymalny
x_star = xp + z * alpha_star;

%% Wartość funkcji celu
f_star = 0.5*x_star'*G*x_star + t'*x_star;

%% Wyświetlenie wyników
disp('Rozwiązanie optymalne x*:');
disp(x_star);

disp('Wartość funkcji celu f(x*):');
disp(f_star);