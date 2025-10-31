# Algorytmy i metody optymalizacji - Raport 1

## Temat: Optymalizacja bez ogranicze - Projekt nr 1; Zestaw nr 13

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

**Parametry**
Wspomnianej wcześniej w treści zadania parametry jakie przyjmuję to:

- $R = 6378137[m]$ - poziom morza względem środka kuli ziemskiej,
- $v_{sygnał} = 299792458 [m/s]$ - prędkość sygnału pochodzącego z satelitów,
- $$ - Wysokość satelity względem powierzchni ziemii //TODO
- $\forall_{i \in S}\ r_i = TODO + R = 26378137[m]$ - wysokość satelity względem środka kuli ziemskiej,
- Szerokość geograficzna satelity $i$ w stopniach:

$i$ | $\theta_i$
----|-----------
1   |
2   |
3   |
4   |
5   |
6   |
7   |
8   |
9   |
10  |
11  |
12  |
13  |

- Długość geograficzna satelity $i$ w stopniach:

$i$ | $\phi_i$
----|----------
1   |
2   |
3   |
4   |
5   |
6   |
7   |
8   |
9   |
10  |
11  |
12  |
13  |

- Czasy nadejścia sygnału $i$ w sekundach:

$i$ | $t_i$
----|--------------------
1   |
2   |
3   |
4   |
5   |
6   |
7   |
8   |
9   |
10  |
11  |
12  |
13  |
