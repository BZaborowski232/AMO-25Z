% ------------------------
% FILE: calculateCoordinates.m
% ------------------------
function [coordinates, squaredResidualNorm] = calculateCoordinates(positions, expectedDistances, startingPosition, options)
distanceErrorFunction = @(x)(distanceError(x, positions, expectedDistances));
[coordinates, squaredResidualNorm] = lsqnonlin(distanceErrorFunction, startingPosition, [], [], options);
end