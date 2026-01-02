function [coordinates, squaredResidualNorm] = calculateCoordinates(positions, expectedDistances, startingState, options)

distanceErrorFunction = @(x)(distanceError(x, positions, expectedDistances));

[coordinates, squaredResidualNorm] = lsqnonlin(distanceErrorFunction, startingState, [], [], options);
end
