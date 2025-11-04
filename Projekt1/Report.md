# Algorytmy i metody optymalizacji - Raport 1

## Temat: Optymalizacja bez ograniczeń - Projekt nr 1; Zestaw nr 13

### Bartosz Zaborowski 319996

#### 1. Dane

Przyjmujemy:

- promień Ziemi (poziom morza): 6378137 m,
- prędkość sygnału z satelitów: 299792458 m/s.

Dane przedstawiają informacje o położeniu (liczba satelit wynosi N = 13) satelitów systemu pozycjonowania (w systemie współrzędnych sferycznych) oraz czasy nadejścia sygnału od nich.

Z treści zadania mamy podane dwie tabele z danymi:
**Położenie satelitów**

| Nr | Szerokość (dzies.) | Długość (dzies.)   | Szerokość kątowa | Długość kątowa    | Wysokość [m n.p.m.] |
| -- | ------------------ | ------------------ | ---------------- | ----------------- | ------------------- |
| 1  | 6.1559355081676    | 52.5457318089284   | 6° 9' 21.37" N   | 52° 32' 44.63" E  | 19 513 264.0        |
| 2  | 47.1886635984881   | 147.8037666254030  | 47° 11' 19.19" N | 147° 48' 13.56" E | 14 002 215.3        |
| 3  | -12.8232765555657  | -9.4526305456900   | 12° 49' 23.80" S | 9° 27' 9.47" W    | 13 862 417.9        |
| 4  | 54.7951930601781   | -127.2512659390310 | 54° 47' 42.70" N | 127° 15' 4.56" W  | 14 061 989.2        |
| 5  | 34.2437389209835   | 25.3517357204992   | 34° 14' 37.46" N | 25° 21' 6.25" E   | 13 761 866.5        |
| 6  | 53.6353221185862   | 64.8608900078692   | 53° 38' 7.16" N  | 64° 51' 39.20" E  | 13 893 736.4        |
| 7  | 43.0785026706136   | -8.0886091756957   | 43° 4' 42.61" N  | 8° 5' 18.99" W    | 13 460 953.4        |
| 8  | 20.1512104981551   | 62.5555486255998   | 20° 9' 4.36" N   | 62° 33' 19.98" E  | 13 819 354.8        |
| 9  | 49.2901079265804   | 44.1040081414650   | 49° 17' 24.39" N | 44° 6' 14.43" E   | 14 015 671.6        |
| 10 | 49.4552880799264   | -67.4173769536602  | 49° 27' 19.04" N | 67° 25' 2.56" W   | 13 800 039.6        |
| 11 | 38.2248532902654   | -46.1640423241860  | 38° 13' 29.47" N | 46° 9' 50.55" W   | 13 357 759.5        |
| 12 | 25.2062832986468   | 83.7474569414005   | 25° 12' 22.62" N | 83° 44' 50.84" E  | 13 759 876.0        |
| 13 | 43.4788434173197   | -7.4150994801044   | 43° 28' 43.84" N | 7° 24' 54.36" W   | 12 778 112.9        |

**Czasy dotarcia sygnału w sekundach**

| Nr satelity | Czas [s]           |
| ----------- | ------------------ |
| 1           | 0.0964296451174393 |
| 2           | 0.0851166508673616 |
| 3           | 0.0838966779463572 |
| 4           | 0.0848758596318232 |
| 5           | 0.0687129525479790 |
| 6           | 0.0707244116606699 |
| 7           | 0.0682187155252768 |
| 8           | 0.0754600110420752 |
| 9           | 0.0692017691788084 |
| 10          | 0.0776484210074374 |
| 11          | 0.0745379551314562 |
| 12          | 0.0781284472368656 |
| 13          | 0.0658486908581309 |

#### 2. Rozwiązanie

Przy opracowywaniu rozwiązania, zdefiniowane zostały pomocnicze zmienne oraz parametry.

**Zbiory:**

- $S = \{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13\}$ - zbiór satelit.

**Parametry:**
Wspomnianej wcześniej w treści zadania parametry jakie przyjmuję to:

- $R = 6378137[m]$ - poziom morza względem środka kuli ziemskiej (promień ziemii),
- $v_{syg} = 299792458 [m/s]$ - prędkość sygnału pochodzącego z satelitów,
- $h_i$ - Wysokość satelity względem powierzchni ziemii
- $\forall_{i \in S}\ r_i = h_i + R = 26378137[m]$ - wysokość satelity względem środka kuli ziemskiej,
- $\theta_i$ - Szerokość geograficzna satelity $i$ w stopniach:
- $\phi_i$ - Długość geograficzna satelity $i$ w stopniach:

Poniżej tabela z wartościami odpowiadającymi każdemu z satelit:

|  i |   $\theta_i$      |    $\phi_i$        |   $h_i$ [m]  | $r_i = R + h_i$ [m] |
| -: | :---------------: | :----------------: | :----------: | :-----------------: |
|  1 |  6.1559355081676  |  52.5457318089284  | 19 513 264.0 |     25 891 401.0    |
|  2 |  47.1886635984881 |  147.8037666254030 | 14 002 215.3 |     20 380 352.3    |
|  3 | -12.8232765555657 |  -9.4526305456900  | 13 862 417.9 |     20 240 554.9    |
|  4 |  54.7951930601781 | -127.2512659390310 | 14 061 989.2 |     20 440 126.2    |
|  5 |  34.2437389209835 |  25.3517357204992  | 13 761 866.5 |     20 140 003.5    |
|  6 |  53.6353221185862 |  64.8608900078692  | 13 893 736.4 |     20 271 873.4    |
|  7 |  43.0785026706136 |  -8.0886091756957  | 13 460 953.4 |     19 839 090.4    |
|  8 |  20.1512104981551 |  62.5555486255998  | 13 819 354.8 |     20 197 491.8    |
|  9 |  49.2901079265804 |  44.1040081414650  | 14 015 671.6 |     20 393 808.6    |
| 10 |  49.4552880799264 |  -67.4173769536602 | 13 800 039.6 |     20 178 176.6    |
| 11 |  38.2248532902654 |  -46.1640423241860 | 13 357 759.5 |     19 735 896.5    |
| 12 |  25.2062832986468 |  83.7474569414005  | 13 759 876.0 |     20 138 013.0    |
| 13 |  43.4788434173197 |  -7.4150994801044  | 12 778 112.9 |     19 156 249.9    |

- $t_i$ - Czasy nadejścia sygnału $i$ w sekundach:

|  i  |      $t_i$ [s]      |
| :-: | :-----------------: |
|  1  | 0.09642964511743930 |
|  2  | 0.08511665086736160 |
|  3  | 0.08389667794635720 |
|  4  | 0.08487585963182320 |
|  5  | 0.06871295254797900 |
|  6  | 0.07072441166066990 |
|  7  | 0.06821871552527680 |
|  8  | 0.07546001104207520 |
|  9  | 0.06920176917880840 |
|  10 | 0.07764842100743740 |
|  11 | 0.07453795513145620 |
|  12 | 0.07812844723686560 |
|  13 | 0.06584869085813090 |

Aby przejść do układu kartezjańskiego $(x, y, z)$  mając podane współrzędne sferyczne $(r, \theta, \phi)$, należy zastosować wzory rozpisane przeze mnie poniżej:

- $$x = x(r,\theta, \phi) = r\ \cos\theta\ \cos\phi$$
- $$y = y(r,\theta, \phi) = r\ \cos\theta\ \sin\phi$$
- $$z = z(r,\theta, \phi) = r\ \sin\theta$$

Kiedy wykonamy podstawienie danych do powyższych wzorów, uzyskamy współrzędne satelitów w układzie kartezjańskim wyrażone w metrach. Poniżej tabela z przeliczonymiwartościami:

| $i$| $x_i$        | $y_i$        | $z_i$       |
| -- | ------------ | ------------ | ----------- |
| 1  | 15654494.42  | 20435085.79  | 2776457.96  |
| 2  | -11720439.55 | 7379678.68   | 14950933.06 |
| 3  | 19467763.22  | -3241242.83  | -4492282.59 |
| 4  | -7132840.60  | -9379731.43  | 16701556.28 |
| 5  | 15045421.80  | 7128566.36   | 11333073.96 |
| 6  | 5106157.74   | 10881138.20  | 16324118.22 |
| 7  | 14346680.47  | -2038925.08  | 13550094.17 |
| 8  | 8738968.74   | 16827214.33  | 6958013.95  |
| 9  | 9551465.72   | 9257309.96   | 15458950.29 |
| 10 | 5036993.30   | -12110950.83 | 15333374.69 |
| 11 | 10738212.51  | -11183646.42 | 12211570.56 |
| 12 | 1984410.46   | 18112094.11  | 8576347.10  |
| 13 | 13784075.04  | -1793932.77  | 13181160.45 |

Aby odtworzyć ze współrzędnych kartezjańskich $(x, y, z)$ współrzędne sferyczne $(r, \theta, \phi)$ należy zastosować wzory odwrotne.

- $$r = \sqrt{x^2 + y^2 + z^2}$$
- $$\theta = \arcsin(\frac{z}{r}) = \arcsin(\frac{z}{\sqrt{x^2 + y^2 + z^2}})$$
- $$\phi = arctg(\frac{y}{x})$$

**Zmienne:**

Przy rozwiązywaniu zadania wprowadziłem następujące zmienne:

- $d_i = v_{syg} \cdot t_i$ - odległość od satelity $i$, oblicznona na podstawie czasu nadejścia sygnału $t_i$ oraz prędkości rozchodzenia się sygnału $v_{syg}$.
- $X_n = \begin{bmatrix}x_n \\ y_n \\ z_n\end{bmatrix}$ - poszukiwane współrzędne własne (układ kartezjański),
- $X_i = \begin{bmatrix}x_i \\ y_i \\ z_i\end{bmatrix}$ - współrzędne satelity $i$ (układ kartezjański),

Następnie przystąpiłem do rozwiązywania zadań z polecenia.

##### 1. Sformułować układ równań określających nasze położenie w układzie współrzędnych kartezjańskich

Istnieją dwa sposoby określenia odległości pomiędzy naszą pozycją a każdym z satelitów:

Pierwszy z nich wykorzystuje czas dotarcia sygnału oraz znaną prędkość jego propagacji. Wówczas dystans można wyrazić zależnością:
$$d_i = v_{\text{syg}} \cdot t_i$$.

Drugi sposób opiera się na geometrycznym obliczeniu odległości w przestrzeni kartezjańskiej, z użyciem wzoru na metrykę euklidesową.
Porównując wartości uzyskane obiema metodami dla każdego satelity, otrzymujemy pojedyncze równanie odpowiadające danemu satelicie.

$$
\forall_{i \in S}\ d_i = |X_n - X_i| = \sqrt{(x_n-x_i)^2 + (y_n-y_i)^2 + (z_n-z_i)^2}
$$

**WERSJA ALTERNATYWNA, JESZCZE DO WERYFIKACJI KTÓRA JEST LEPSZA I ZOSTANIE**

1. Sformułowanie układu równań określających nasze położenie w układzie współrzędnych kartezjańskich

Istnieją dwa podejścia do określenia odległości między odbiornikiem a satelitą.  

Pierwsze wykorzystuje czas nadejścia sygnału $t_i$ i prędkość propagacji sygnału $v_{\text{sygnał}}$, co daje pseudoodległość:

$$
d_i^{(\text{time})} = v_{\text{sygnał}} \, (t_i - \Delta t),
$$

gdzie $\Delta t$ jest nieznanym przesunięciem zegara odbiornika (tzw. *bias*).  

Drugie podejście to bezpośrednie obliczenie odległości geometrycznej w układzie kartezjańskim:

$$
d_i^{(\text{geom})} = \| X_n - X_i \| = \sqrt{(x_n - x_i)^2 + (y_n - y_i)^2 + (z_n - z_i)^2}.
$$

Porównując obie wartości dla każdego satelity, otrzymujemy układ równań:

$$
\forall_{i \in S} : \| X_n - X_i \| - v_{\text{sygnał}} \, (t_i - \Delta t) = 0.
$$

W praktyce układ ten rozwiązuje się w sensie najmniejszych kwadratów (ze względu na obecność błędów pomiarowych), minimalizując funkcję celu:

$$
F(X_n, \Delta t) = \sum_{i \in S} \left( \| X_n - X_i \| - v_{\text{sygnał}} \, (t_i - \Delta t) \right)^2.
$$

**KONIEC WERSJI ALTERNATYWNEJ DLA ZADANIA 1**

##### 2. Sformułować zadanie optymalizacji bez ograniczeń stosując metodę najmniejszych kwadratów

Możemy wprowadzić funkcję $f_i$, opisującą różnicę pomiędzy odległością geometryczną w układzie kartezjańskim, a odległością wyznaczoną na podstawie czasu dotarcia sygnału:

$$
f_i(x_n, y_n, z_n) = \sqrt{(x_n-x_i)^2 + (y_n-y_i)^2 + (z_n-z_i)^2} - d_i
$$

Na podstawie tej funkcji można wyznaczyć macierz Jacobiego, zbudowaną z pochodnych cząstkowych względem współrzędnych $(x_n, y_n, z_n)$. Macierz ta może być następnie wykorzystana w iteracyjnym algorytmie Levenberga–Marquardta:

- $\frac{\partial f_i}{\partial x_n} = \frac{x_n - x_i}{\sqrt{(x_n-x_i)^2 + (y_n-y_i)^2 + (z_n-z_i)^2}}$

- $\frac{\partial f_i}{\partial y_n} = \frac{y_n - x_i}{\sqrt{(x_n-x_i)^2 + (y_n-y_i)^2 + (z_n-z_i)^2}}$

- $\frac{\partial f_i}{\partial z_n} = \frac{z_n - x_i}{\sqrt{(x_n-x_i)^2 + (y_n-y_i)^2 + (z_n-z_i)^2}}$

W efekcie, całe zadanie można sformułować jako problem optymalizacji nieliniowej bez ograniczeń, polegający na minimalizacji sumy kwadratów funkcji $f_i$:

$$
\min_{X_n} \sum_{i \in S} \left( \sqrt{(x_n - x_i)^2 + (y_n - y_i)^2 + (z_n - z_i)^2} - d_i \right)^2
$$

##### 3. Wyznaczyć swoje położenie rozwiązując: sformułowane powyżej zadanie optymalizacji za pomocą metody optymalizacji realizującej metodę Levenberga-Marquardta do rozwiązywania zadań regresji nieliniowej z toolbox-u Optimization programu MATLAB (lsqnonlin) lub bibliotek scipy i numpy w Python

Przy rozwiązywaniu zadania posłużyłem się programem MATLAB, a konkretniej toolboxem Optimization. Do obliczenia położenia odbiornika wykorzystano metodę nieliniowej regresji najmniejszych kwadratów, zrealizowaną funkcją lsqnonlin z algorytmem Levenberga-Marquardta.

**a) Konwersja współrzędnych satelitów**
Współrzędne satelitów podane w układzie sferycznym (kąty theta, phi i wysokość nad Ziemią) zostały przekształcone na układ kartezjański $(x, y, z)$ za pomocą wzorów:

- $$x = x(r,\theta, \phi) = r\ \cos\theta\ \cos\phi$$
- $$y = y(r,\theta, \phi) = r\ \cos\theta\ \sin\phi$$
- $$z = z(r,\theta, \phi) = r\ \sin\theta$$
gdzie:

$r_i = R + h_i$ jest całkowitą odległością od środka Ziemii, a $R = 6378137m$ to promień Ziemii.

W MATLAB-ie implementacja wygląda następująco:

```matlab
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
```

Dzięki temu otrzymano współrzędne kartezjańskie wszystkich 13 satelitów w metrach.

**b) Wyznaczenie pozycji odbiornika**

Pozycję odbiornika określono poprzez minimalizację błędu pomiędzy odległościami geometrycznymi do satelitów a zmierzonymi pseudodystansami.

$$d_i = v_{syg} * t_i$$
gdzie:

- $v_{syg}$ = 299 792 458 m/s - prędkość nadejścia sygnału
- $t_i$ - czas nadejścia sygnału

Funkcja celu dla $lsqnonlin$ jest następująca:

```matlab
fun = @(Xn) sqrt((Xn(1)-X(:,1)).^2 + (Xn(2)-X(:,2)).^2 + (Xn(3)-X(:,3)).^2) - d;
```

Optymalizacja została uruchomiona z przyjętym przykładowym punktem startowym:

```matlab
X0 = [0, 0, 0];
options = optimoptions('lsqnonlin','Display','iter','Algorithm','levenberg-marquardt');
[X_sol, resnorm] = lsqnonlin(fun, X0, [], [], options);
```

Otrzymane wyniki położenia we współrzędnych kartezjańskich prezentują się następująco:

$x$            | $y$            | $z$
---------------|----------------|---------------
-376600        | -259200        | -2990000

Po przekształceniu współrzędnych do układu współrzędnych sferycznych uzyskujemy:

szerokość    | długość      |
-------------|--------------|---------------
-81.3075     | -145.462     |
81°18'27"S   | 145°27'43"W  |
