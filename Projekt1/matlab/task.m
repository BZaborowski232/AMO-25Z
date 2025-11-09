% ------------------------
% FILE: task.m
% ------------------------
% Main script adapted to your data. Place this file and the helper
% functions (below) in the same folder and run `task` in MATLAB.


close all
clear
clc


% physical constants
radius = 6378137; % Earth's radius used as reference [m]
velocity = 299792458; % speed of light [m/s]

% --- Satellite data (spherical: latitude, longitude, radius) ---
% Rows: [latitude_deg, longitude_deg, radius_m]
sphericalPositions = [
	6.1559355081676 52.5457318089284 19513264.0;
	47.1886635984881 147.8037666254030 14002215.3;
	-12.8232765555657 -9.4526305456900 13862417.9;
	54.7951930601781 -127.2512659390310 14061989.2;
	34.2437389209835 25.3517357204992 13761866.5;
	53.6353221185862 64.8608900078692 13893736.4;
	43.0785026706136 -8.0886091756957 13460953.4;
	20.1512104981551 62.5555486255998 13819354.8;
	49.2901079265804 44.1040081414650 14015671.6;
	49.4552880799264 -67.4173769536602 13800039.6;
	38.2248532902654 -46.1640423241860 13357759.5;
	25.2062832986468 83.7474569414005 13759876.0;
	43.4788434173197 -7.4150994801044 12778112.9
	];


% --- Measured signal times (s) ---
times = [
	0.0964296451174393;
	0.0851166508673616;
	0.0838966779463572;
	0.0848758596318232;
	0.0687129525479790;
	0.0707244116606699;
	0.0682187155252768;
	0.0754600110420752;
	0.0692017691788084;
	0.0776484210074374;
	0.0745379551314562;
	0.0781284472368656;
	0.0658486908581309
	];

distances = times .* velocity; % convert to metres


% convert satellite positions to Cartesian coordinates
positions = sphericalToCartesian(sphericalPositions);


% default solver options
options = optimoptions( ...
	"lsqnonlin", ...
	"Algorithm", "levenberg-marquardt", ...
	"SpecifyObjectiveGradient", true, ...
	"Display", "iter" ... % set to 'off' to suppress output
	);

% --- Solve from a sensible starting position (near Earth surface) ---
startingPosition = [0, 0, radius]; % initial guess (x,y,z)
[coordinates, squaredResidualNorm] = calculateCoordinates(positions, distances, startingPosition, options);


fprintf("Main result (Cartesian): x = %f, y = %f, z = %f\n", coordinates(1), coordinates(2), coordinates(3));
sphericalCoordinates = cartesianToSpherical(coordinates);
fprintf("Main result (spherical): lat = %f deg, lon = %f deg, radius = %f m, height = %f m\n", ...
	sphericalCoordinates(1), sphericalCoordinates(2), sphericalCoordinates(3), sphericalCoordinates(3) - radius);
fprintf("Squared residual norm: %e\n", squaredResidualNorm);


%% --- Experiments: starting positions, function tolerance, data disturbance ---
% You can reuse the loops from your colleague's script. Examples below.


% (A) Starting positions
startingPositions = [
	0 0 0;
	radius radius radius;
	[1 1 1]*1e6;
	[1 1 1]*1e7;
	[1 1 1]*5e7
	];

fprintf('\n--- Starting position experiments ---\n');
for i = 1:size(startingPositions,1)
	sp = startingPositions(i,:);
	[coords, rnorm] = calculateCoordinates(positions, distances, sp, options);
	s = cartesianToSpherical(coords);
	fprintf('\nStart [%g %g %g] => lat=%f lon=%f height=%f rnorm=%e\n', sp(1), sp(2), sp(3), s(1), s(2), s(3)-radius, rnorm);
end

% (B) Function tolerances
fprintf('\n--- Function tolerance experiments ---\n');
funcTol = [1e-12 1e-10 1e-8 1e-6 1e-4 1e-2 1e-1 1 1e1];
for t = funcTol
	optsT = optimoptions(options, 'FunctionTolerance', t, 'Display','off');
	[coords, rnorm] = calculateCoordinates(positions, distances, startingPosition, optsT);
	s = cartesianToSpherical(coords);
	fprintf('Tol=%g => lat=%f lon=%f height=%f rnorm=%e\n', t, s(1), s(2), s(3)-radius, rnorm);
end

% (C) Disturbance in satellite positions
fprintf('\n--- Satellite data disturbance experiments ---\n');
disturbs = [1e-6 1e-4 1e-2 1e-1 1 1e1];
for d = disturbs
	rng(0); % reproducible
	pert = -d + (2*d).*rand(size(positions));
	posd = positions + pert;
	[coords, rnorm] = calculateCoordinates(posd, distances, startingPosition, options);
	s = cartesianToSpherical(coords);
	fprintf('Perturb=%g => lat=%f lon=%f height=%f rnorm=%e\n', d, s(1), s(2), s(3)-radius, rnorm);
end

% (D) Disturbance in times
fprintf('\n--- Time measurement disturbance experiments ---\n');
timeDisturbs = [1e-12 1e-10 1e-8 1e-6 1e-4 1e-2];
for dt = timeDisturbs
	rng(0);
	td = -dt + (2*dt).*rand(size(times));
	[coords, rnorm] = calculateCoordinates(positions, (times+td).*velocity, startingPosition, options);
	s = cartesianToSpherical(coords);
	fprintf('TimePert=%g => lat=%f lon=%f height=%f rnorm=%e\n', dt, s(1), s(2), s(3)-radius, rnorm);
end

% Save final result to file
save('result.mat', 'coordinates', 'sphericalCoordinates', 'squaredResidualNorm');