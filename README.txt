- learnData.m - Zestaw danych ucz�cych dla sieci. Zawiera zdefiniowane wektory reprezentuj�ce konkretne cyfry (w postaci bitmap 7x5).

- numberRecognition.m - Funkcja tworz�ca, konfiguruj�ca, inicjalizuj�ca i trenuj�ca sie� neuronow� rozpoznaj�c� cyfry. 
Jako parametr przyjmuje poziom szumu zestawu
ucz�cego a zwraca referencje do utworzonej sieci oraz rysuje wykres
przestawiaj�cy ile znak�w rozpozna�a sie� w zale�no�ci od tego jak
bardzo by�y zdeformowane.

- useNet.m - jako parametr przyjmuje wcze�niej utworzon� sie� oraz
zestaw danych (wektor 35x1 - jedna cyfra) . Funkcja zwraca �e albo nie rozpozna�a
liczby albo podaje kt�r� liczb� rozpozna�a