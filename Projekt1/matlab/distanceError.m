function [error, jacobian] = distanceError(currentState, positions, expectedDistances)
% currentState = [x; y; z; clockBias]
x = currentState(1);
y = currentState(2);
z = currentState(3);
b = currentState(4); % bias zegara w sekundach

c = 299792458; % prędkość światła

% Liczba satelitów
m = size(positions, 1);

% Odległość geometryczna
geometricDistance = sqrt((x - positions(:, 1)).^2 + (y - positions(:, 2)).^2 + (z - positions(:, 3)).^2 );

% Pseudoodległość modelowana
modeledDistance = geometricDistance + c * b;

% Błąd
error = modeledDistance - expectedDistances;

% Jacobian
if nargout > 1
	jacobian = zeros(m, 4);
	jacobian(:, 1) = (x - positions(:, 1)) ./ geometricDistance;
	jacobian(:, 2) = (y - positions(:, 2)) ./ geometricDistance;
	jacobian(:, 3) = (z - positions(:, 3)) ./ geometricDistance;
	jacobian(:, 4) = c * ones(m, 1); % pochodna po biasie
end
end
