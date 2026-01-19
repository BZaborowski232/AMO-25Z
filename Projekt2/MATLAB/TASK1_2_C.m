%% Zadanie 2 (C)
% Metoda eliminacji uogólnionej z wykorzystaniem jądra macierzy A
% (Implementacja automatyczna z wykrywaniem wymiaru jądra)

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

%% 1. Wyznaczenie punktu szczególnego (xp)
% Punkt spełniający A*xp = b.
% Ponieważ A jest kwadratowa i odwracalna, xp jest jedynym rozwiązaniem układu.
xp = A \ b;  % <--- MATLAB wylicza punkt szczególny

disp('Punkt szczególny xp:');
disp(xp);

%% 2. Wyznaczenie macierzy jądra (Z)
% Szukamy wektorów, dla których A*z = 0.
% Używamy funkcji 'null' do znalezienia bazy przestrzeni zerowej.
Z = null(A); 

% Sprawdzenie wymiaru jądra
if isempty(Z)
    disp('Jądro macierzy A jest puste (brak stopni swobody).');
    disp('Optymalizacja w podprzestrzeni nie jest wymagana.');
    
    % Skoro brak swobody ruchu, punkt optymalny to po prostu punkt szczególny
    x_star = xp;
    
else
    % Ten blok wykonałby się, gdybyśmy mieli mniej ograniczeń (np. jak w Zad 1)
    disp('Znaleziono kierunki swobodne w jądrze macierzy A.');
    
    % Wzór na optymalny krok alpha (analogicznie do Zadania 1C):
    % alpha* = -(Z'*G*Z) \ (Z'*G*xp + Z'*t)
    numerator = Z' * G * xp + Z' * t;
    denominator = Z' * G * Z;
    
    alpha_star = -denominator \ numerator;
    
    x_star = xp + Z * alpha_star;
end

%% Wartość funkcji celu
f_star = 0.5 * x_star' * G * x_star + t' * x_star;

%% Wyświetlenie wyników
disp(' ');
disp('Rozwiązanie optymalne x*:');
disp(x_star);

disp('Wartość funkcji celu f(x*):');
disp(f_star);