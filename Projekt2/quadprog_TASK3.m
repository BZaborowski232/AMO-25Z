% Dane
G = [2 0.5 0; 0.5 1.5 0.2; 0 0.2 1];
t = [1; 0.5; 0.8];

Aeq = [1 1 1];
beq = 100;

Aineq = [-1 0 0; 0 -1 0; 0 0 -1; 1 0 0; 0 1 0; 0 0 1];
bineq = [-10; -5; -8; 50; 40; 60];

options = optimoptions('quadprog','Display','off');

[x_star, fval] = quadprog(G, t, Aineq, bineq, Aeq, beq, [], [], [], options);

disp('Rozwiązanie optymalne:');
disp(x_star);
disp('Wartość funkcji celu:');
disp(fval);