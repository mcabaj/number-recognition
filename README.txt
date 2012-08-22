- learnData.m - Zestaw danych ucz¹cych dla sieci. Zawiera zdefiniowane wektory reprezentuj¹ce konkretne cyfry (w postaci bitmap 7x5).

- numberRecognition.m - Funkcja tworz¹ca, konfiguruj¹ca, inicjalizuj¹ca i trenuj¹ca sieæ neuronow¹ rozpoznaj¹c¹ cyfry. 
Jako parametr przyjmuje poziom szumu zestawu
ucz¹cego a zwraca referencje do utworzonej sieci oraz rysuje wykres
przestawiaj¹cy ile znaków rozpozna³a sieæ w zale¿noœci od tego jak
bardzo by³y zdeformowane.

- useNet.m - jako parametr przyjmuje wczeœniej utworzon¹ sieæ oraz
zestaw danych (wektor 35x1 - jedna cyfra) . Funkcja zwraca ¿e albo nie rozpozna³a
liczby albo podaje któr¹ liczbê rozpozna³a