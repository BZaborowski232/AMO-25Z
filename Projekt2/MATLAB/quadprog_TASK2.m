% Dane problemu
G = [2 0; 0 1];
t = [-2; -1];
A = [1 1; -1 0; 0 -1]; % przykładowe nierówności: x1 + x2 <= 1, x1 >= 0, x2 >= 0
b = [1; 0; 0];

% Opcje solvera
options = optimoptions('quadprog', 'Display', 'off');

% Rozwiązanie problemu
[x_star, fval] = quadprog(G, t, A, b, [], [], [], [], [], options);

% Wyświetlenie wyników
disp('Rozwiązanie numeryczne (quadprog):');
disp(x_star);
disp('Wartość funkcji celu:');
disp(fval);