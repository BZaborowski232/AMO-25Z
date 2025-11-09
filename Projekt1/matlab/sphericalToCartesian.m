% ------------------------
% FILE: sphericalToCartesian.m
% ------------------------
function [positions] = sphericalToCartesian(sphericalPositions)
[len, ~] = size(sphericalPositions);
positions = zeros(len, 3);


% sphericalPositions: [lat_deg, lon_deg, r]
positions(:, 1) = sphericalPositions(:, 3) ...
	.* cos(deg2rad(sphericalPositions(:, 1))) ...
	.* cos(deg2rad(sphericalPositions(:, 2)));


positions(:, 2) = sphericalPositions(:, 3) ...
	.* cos(deg2rad(sphericalPositions(:, 1))) ...
	.* sin(deg2rad(sphericalPositions(:, 2)));


positions(:, 3) = sphericalPositions(:, 3) ...
	.* sin(deg2rad(sphericalPositions(:, 1)));
end