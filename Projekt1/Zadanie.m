%% Konwersja współrzędnych sferycznych satelitów na kartezjańskie
clc; clear;

% Stałe
R = 6378137;           % promień Ziemi [m]

% Współrzędne satelitów w stopniach i wysokość nad Ziemią [m]
theta_deg = [6.1559355081676, 47.1886635984881, -12.8232765555657, ...
    54.7951930601781, 34.2437389209835, 53.6353221185862, ...
    43.0785026706136, 20.1512104981551, 49.2901079265804, ...
    49.4552880799264, 38.2248532902654, 25.2062832986468, ...
    43.4788434173197];

phi_deg = [52.5457318089284, 147.8037666254030, -9.4526305456900, ...
    -127.2512659390310, 25.3517357204992, 64.8608900078692, ...
    -8.0886091756957, 62.5555486255998, 44.1040081414650, ...
    -67.4173769536602, -46.1640423241860, 83.7474569414005, ...
    -7.4150994801044];

h_i = [19513264.0, 14002215.3, 13862417.9, 14061989.2, 13761866.5, ...
    13893736.4, 13460953.4, 13819354.8, 14015671.6, 13800039.6, ...
    13357759.5, 13759876.0, 12778112.9];

% Całkowita odległość od środka Ziemi
r_i = R + h_i;

% Konwersja stopni na radiany
theta_rad = deg2rad(theta_deg);
phi_rad   = deg2rad(phi_deg);

% Współrzędne kartezjańskie
x_i = r_i .* cos(theta_rad) .* cos(phi_rad);
y_i = r_i .* cos(theta_rad) .* sin(phi_rad);
z_i = r_i .* sin(theta_rad);

% Wyświetlenie wyników
fprintf('Współrzędne kartezjańskie satelitów [m]:\n');
fprintf('i\t x_i\t\t y_i\t\t z_i\n');
for i = 1:length(x_i)
    fprintf('%d\t %.2f\t %.2f\t %.2f\n', i, x_i(i), y_i(i), z_i(i));
end


%% Wyznaczanie pozycji odbiornika
% metodą Levenberga-Marquardta (lsqnonlin)

% Stałe
v_syg = 299792458; % prędkość sygnału [m/s]

% Współrzędne kartezjańskie satelitów wyliczone wcześniej (x_i, y_i, z_i)
X = [15654494.42, 20435085.79,  2776457.96;
    -11720439.55, 7379678.68, 14950933.06;
    19467763.22, -3241242.83, -4492282.59;
    -7132840.60, -9379731.43, 16701556.28;
    15045421.80, 7128566.36, 11333073.96;
    5106157.74, 10881138.20, 16324118.22;
    14346680.47, -2038925.08, 13550094.17;
    8738968.74, 16827214.33, 6958013.95;
    9551465.72, 9257309.96, 15458950.29;
    5036993.30, -12110950.83, 15333374.69;
    10738212.51, -11183646.42, 12211570.56;
    1984410.46, 18112094.11, 8576347.10;
    13784075.04, -1793932.77, 13181160.45];

% Czasy nadejścia sygnału [s]
t = [0.0964296451174393;
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
    0.0658486908581309];

% Odległości pseudodystansowe
d = v_syg * t;

% Funkcja celu dla lsqnonlin (różnice między odległością geometryczną a zmierzoną)
fun = @(Xn) sqrt((Xn(1)-X(:,1)).^2 + (Xn(2)-X(:,2)).^2 + (Xn(3)-X(:,3)).^2) - d;

% Punkt startowy (przykładowy)
X0 = [0, 0, 0]; % możesz eksperymentować z innymi wartościami

% Wywołanie lsqnonlin
options = optimoptions('lsqnonlin','Display','iter','Algorithm','levenberg-marquardt');
[X_sol, resnorm, residual, exitflag, output] = lsqnonlin(fun, X0, [], [], options);

% Wyświetlenie wyniku
fprintf('Rozwiązanie w układzie kartezjańskim [x, y, z] [m]:\n');
disp(X_sol);

% Konwersja na szerokość i długość geograficzną
R = 6378137; % promień Ziemi
x = X_sol(1); y = X_sol(2); z = X_sol(3);
lat = asind(z / sqrt(x^2 + y^2 + z^2));
lon = atan2d(y, x);

fprintf('Latitude: %.6f°\n', lat);
fprintf('Longitude: %.6f°\n', lon);
