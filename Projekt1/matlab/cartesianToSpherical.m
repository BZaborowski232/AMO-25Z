function [positions] = cartesianToSpherical(cartesianPositions)
[length, ~] = size(cartesianPositions);
positions = zeros(length, 3);

positions(:, 3) = sqrt(cartesianPositions(:, 1) .^ 2 + cartesianPositions(:, 2) .^ 2 + cartesianPositions(:, 3) .^ 2);
positions(:, 1) = rad2deg(asin(cartesianPositions(:, 3) ./ positions(:, 3)));
positions(:, 2) = rad2deg(atan2(cartesianPositions(:, 2), cartesianPositions(:, 1)));
end
