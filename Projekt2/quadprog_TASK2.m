function quadprog_TASK2
% quadprog_TASK2 - rozwiązanie numeryczne zadania QP z dwoma ograniczeniami

% Dane problemu
G = [2 0; 0 1];
t = [-2; -1];
Aeq = [1 1; 1 -1];
beq = [1; 0];

% Opcje solvera
options = optimoptions('quadprog', 'Display', 'off');

% Rozwiązanie problemu
[x_star, fval] = quadprog(G, t, [], [], Aeq, beq, [], [], [], options);

% Wyświetlenie wyników
disp('Rozwiązanie numeryczne (quadprog):');
disp(x_star);
disp('Wartość funkcji celu:');
disp(fval);
end
