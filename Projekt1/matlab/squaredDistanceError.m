function [error, jacobian] = squaredDistanceError(currentPosition, positions, expectedDistances)
calculateDistancesSquared = ((currentPosition(1) - positions(:, 1)) .^ 2 + (currentPosition(2) - positions(:, 2)) .^ 2 + (currentPosition(3) - positions(:, 3)) .^ 2);

error = calculateDistancesSquared - expectedDistances.^2;

[m, ~] = size(positions);
jacobian = zeros(m, 3);
jacobian(:, 1) = 2 * (currentPosition(1) - positions(:, 1));
jacobian(:, 2) = 2 * (currentPosition(2) - positions(:, 2));
jacobian(:, 3) = 2 * (currentPosition(3) - positions(:, 3));
end
