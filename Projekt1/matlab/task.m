
close all
clear
clc

% Stałe fizyczne
radius = 6378137;           % promień Ziemi (m)
velocity = 299792458;       % prędkość światła (m/s)

% Pozycje satelitów w układzie sferycznym
% Format: [theta (deg), phi (deg), radius (m)]
sphericalPositions = [
	6.1559355081676     52.5457318089284    25891401.0;
	47.1886635984881    147.8037666254030   20380352.3;
	-12.8232765555657   -9.4526305456900    20240554.9;
	54.7951930601781    -127.2512659390310  20440126.2;
	34.2437389209835    25.3517357204992    20140003.5;
	53.6353221185862    64.8608900078692    20271873.4;
	43.0785026706136    -8.0886091756957    19839090.4;
	20.1512104981551    62.5555486255998    20197491.8;
	49.2901079265804    44.1040081414650    20393808.6;
	49.4552880799264    -67.4173769536602   20178176.6;
	38.2248532902654    -46.1640423241860   19735896.5;
	25.2062832986468    83.7474569414005    20138013.0;
	43.4788434173197    -7.4150994801044    19156249.9
	];

% Zmierzone czasy sygnałów od satelitów (sekundy)
times = [
	0.09642964511743930;
	0.08511665086736160;
	0.08389667794635720;
	0.08487585963182320;
	0.06871295254797900;
	0.07072441166066990;
	0.06821871552527680;
	0.07546001104207520;
	0.06920176917880840;
	0.07764842100743740;
	0.07453795513145620;
	0.07812844723686560;
	0.06584869085813090
	];

% Zamiana czasu na pseudoodległość
distances = times * velocity;

% Konwersja satelitów do układu kartezjańskiego
positions = sphericalToCartesian(sphericalPositions);

% Opcje solvera
options = optimoptions( ...
	"lsqnonlin", ...
	"Algorithm", "levenberg-marquardt", ...
	"SpecifyObjectiveGradient", true, ...
	"Display", "off" ...
	);

% Wektor startowy: x, y, z, bias_zegara
startingState = [radius; radius; radius; 0];

% Wywołanie solvera
[solution, squaredResidualNorm] = calculateCoordinates(positions, distances, startingState, options);

% Rozpakowanie wyniku
x = solution(1);
y = solution(2);
z = solution(3);
bias = solution(4);

% Wyświetlenie wyników
fprintf("Result (ECEF): x = %.3f, y = %.3f, z = %.3f\n", x, y, z);
fprintf("Clock bias (s): %.10e\n", bias);
fprintf("Clock bias (m): %.3f\n", bias * velocity);

% Przeliczenie pozycji na współrzędne sferyczne
sphericalCoordinates = cartesianToSpherical([x, y, z]);

fprintf("Result (spherical): theta = %.6f deg, phi = %.6f deg, radius = %.3f m\n", sphericalCoordinates(1), sphericalCoordinates(2), sphericalCoordinates(3));

fprintf("Height above Earth (m): %.3f\n", sphericalCoordinates(3) - radius);

fprintf("Squared residual norm: %.6f\n", squaredResidualNorm);


% Printq w formacie od razu z linkiem do google mapsa
% Wyciągnięcie wynikowych współrzędnych
lat = sphericalCoordinates(1);  % phi = latitude
lon = sphericalCoordinates(2);  % theta = longitude

% Ustalenie hemisfer
if lat >= 0
	latHem = 'N';
else
	latHem = 'S';
end

if lon >= 0
	lonHem = 'E';
else
	lonHem = 'W';
end

latAbs = abs(lat);
lonAbs = abs(lon);

disp(' ');
disp('--- Ostateczna wyliczona pozycja odbiornika ---');
fprintf('Latitude:  %.8f° %s\n', latAbs, latHem);
fprintf('Longitude: %.8f° %s\n', lonAbs, lonHem);

% Gotowy link do Google Maps
fprintf('\nGoogle Maps link:\nhttps://www.google.com/maps/place/%.8f°%s+%.8f°%s\n', ...
	latAbs, latHem, lonAbs, lonHem);

%% ============================================================
%   Eksperymenty:
%   Sprawdzamy wpływ zmiany:
%     - A - punktu startowego
%     - B - tolerancji funkcji stopu
%     - C - zakłóceń w danych (np. pozycjach satelitów)
%     - D - zakłóceń w zmierzonych czasach
%% ============================================================

fprintf('\n=====================\nEksperymenty\n=====================\n');

%% (A) Zmiany punktu startowego
fprintf('\n--- (A) Wpływ zmiany punktu startowego ---\n');

startingPositions = [
	0            0            0            0;
	radius       radius       radius       0;
	1e6          1e6          1e6          0;
	1e7          1e7          1e7          0;
	5e7          5e7          5e7          0;
	];

for i = 1:size(startingPositions,1)
	sp = startingPositions(i,:);
	[sol, rnorm] = calculateCoordinates(positions, distances, sp, options);

	x = sol(1); y = sol(2); z = sol(3);
	s = cartesianToSpherical([x y z]);

	fprintf("Start [%g %g %g %g] => lat=%.6f lon=%.6f height=%.3f rnorm=%e\n", ...
		sp(1), sp(2), sp(3), sp(4), ...
		s(1), s(2), s(3) - radius, rnorm);
end


%% (B) Wpływ tolerancji funkcji stopu
fprintf('\n--- (B) Wpływ tolerancji funkcji stopu ---\n');

funcTol = [1e-14 1e-12 1e-10 1e-8 1e-6 1e-4 1e-2 1 1e1];

for t = funcTol
	optsT = optimoptions(options, 'FunctionTolerance', t, 'Display','off');

	[sol, rnorm] = calculateCoordinates(positions, distances, startingState, optsT);

	x = sol(1); y = sol(2); z = sol(3);
	s = cartesianToSpherical([x y z]);

	fprintf("Tol=%g => lat=%.6f lon=%.6f height=%.3f rnorm=%e\n", ...
		t, s(1), s(2), s(3)-radius, rnorm);
end


%% (C) Wpływ zakłóceń w danych (np. pozycjach satelitów)
fprintf('\n--- (C) Wpływ zakłóceń w danych (np. pozycjach satelitów) ---\n');

disturbs = [1e-6 1e-4 1e-2 1e-1 1 10 100];

for d = disturbs
	rng(0);
	pert = -d + (2*d) * rand(size(positions));
	posd = positions + pert;

	[sol, rnorm] = calculateCoordinates(posd, distances, startingState, options);

	x = sol(1); y = sol(2); z = sol(3);
	s = cartesianToSpherical([x y z]);

	fprintf("Perturb=%g => lat=%.6f lon=%.6f height=%.3f rnorm=%e\n", ...
		d, s(1), s(2), s(3)-radius, rnorm);
end


%% (D) Wpływ zakłóceń w danych (np. zmierzonych czasach)
fprintf('\n--- (D) Wpływ zakłóceń w danych (np. zmierzonych czasach) ---\n');

timeDisturbs = [1e-12 1e-10 1e-8 1e-6 1e-4 1e-2];

for dt = timeDisturbs
	rng(0);
	td = -dt + (2*dt) * rand(size(times));

	disturbedDistances = (times + td) * velocity;

	[sol, rnorm] = calculateCoordinates(positions, disturbedDistances, startingState, options);

	x = sol(1); y = sol(2); z = sol(3);
	s = cartesianToSpherical([x y z]);

	fprintf("TimePert=%g => lat=%.6f lon=%.6f height=%.3f rnorm=%e\n", ...
		dt, s(1), s(2), s(3)-radius, rnorm);
end


%% Zapis
save('result.mat', 'solution', 'sphericalCoordinates', 'squaredResidualNorm');

fprintf("\nEksperymenty zakończone pomyślnie, wszystkie wyniki zapisane do result.mat\n");