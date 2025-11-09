% ------------------------
% FILE: distanceError.m
% ------------------------
function [error, jacobian] = distanceError(currentPosition, positions, expectedDistances)
calculateDistances = sqrt( ...
	(currentPosition(1) - positions(:, 1)) .^ 2 ...
	+ (currentPosition(2) - positions(:, 2)) .^ 2 ...
	+ (currentPosition(3) - positions(:, 3)) .^ 2 ...
	);
error = calculateDistances - expectedDistances;


[m, ~] = size(positions);
jacobian = zeros(m, 3);
jacobian(:, 1) = (currentPosition(1) - positions(:, 1)) ./ calculateDistances;
jacobian(:, 2) = (currentPosition(2) - positions(:, 2)) ./ calculateDistances;
jacobian(:, 3) = (currentPosition(3) - positions(:, 3)) ./ calculateDistances;
end
