function net = numberRecognition(noise)
%% Funkcja, kt�ra tworzy, konfiguruje, trenuje oraz testuje sie� neuronow�
% stworzon� do rozpoznawania cyfr
%
%  NET = NUMBER_RECOGNITION()
%  Inputs:
%    NOISE - liczba okre�laj�ca poziom zaszumienia (odpowiada wariancji przy
%    generowaniu liczb losowych z rozk�adu normalnego) zestawu ucz�cego
%  Returns:
%    NET - stworzona przez funkcje sie� s�u��ca do rozpoznawania cyfr
%
% Marek Cabaj & Kamil Kr�l
% 03.04.2012



%% Tworzenie zestawu danych do uczenia 
[perfect_X,perfect_T] = learnData(); % u�ycie funkcji learn_data() w celu otrzymania zestawu 
                      % dziesi�ciu idealnie utworzonych cyfr (X) wraz z zestawem  
                      % poprawnych odpowiedzi dla sieci (T)

N = 20; % liczba kopii zestawu danych kt�re zostan� poddane deformacji
deformed_X = repmat(perfect_X,1,N); % tworzenie N-kopii zestawu danych X
deformed_X = deformed_X +random('Normal',0,noise,35,10*N); % deformacja wszystkich kopii 
% losowe liczby powstaj� z rozk�adu normalnego ze �redni�=0.0 oraz
% wariancj�=noise, rozmiar macierzy liczb losowych to 35x(10*N)
deformed_X = max(deformed_X,0); % wszystkie pola mniejsze od 0 s� zast�piane przez 0 
deformed_X = min(deformed_X,1); % wszystkie pola wi�ksze od 1 s� zast�piane przez 1

deformed_T = repmat(perfect_T,1,N); % tworzenie N-kopii odpowiedzi T (zostaj� dopasowane do zestawu deformed_X)

X = [perfect_X,deformed_X]; % ostateczny zestaw ucz�cy zawiera idealne cyfry oraz zdeformowane kopie cyfr
T = [perfect_T,deformed_T]; % zestaw odpowiedzi jest dopasowany do zestawu ucz�cego

%% Tworzenie sieci neuronowej
network = feedforwardnet(20);   % tworzenie sieci neuronowej typu feedforward z 20 neuronami

%% Konfigurowanie sieci
network.divideFcn = '';       % wy��czenie funkcji dziel�cej zestaw danych na Train/Validate/Test
network.initFcn = 'initlay';  % ustawienie funkcji, kt�ra  inicjalizuje wagi i bias'y 

%% Inicjalizacja wagi i bias'�w
network = init(network);     % inicjalizacja sieci neuronowej

%% Trenowanie sieci
network = train(network,X,T);   % trenowanie sieci

%% Testowanie sieci
testN = 50; %liczba kopii zestawu danych kt�ry b�dzie s�u�y� do testowania sieci
pT = eye(10);  %tworzenie macierzy jednostkowej 10x10
pT = repmat(pT,1,testN); %tworzenie N-kopii macierzy jednostkowej

variation = 0:0.01:1;   % kolejne poziomy wariancji rozk�adu normlanego (szum)
iterations = length(variation); % liczba poziom�w szumu
numRecognized = zeros(1,iterations);  % tabela rozpoznanych cyfr w kolejnych iteracjach

for i = 1:iterations
    test_X = min(max(repmat(perfect_X,1,testN)+random('Normal',0,variation(i),35,10*testN),0),1);
    test_T = network(test_X);   % tworzenie zaszumionych danych - analogicznie do zestawu ucz�cego
    test_T
    recognized = pT-compet(test_T); 
    recognized = abs(recognized);
    recognized = sum(sum(recognized))/2;    % sumowanie wszystkich r�nic pomi�dzy odpowiedzi� wzorcow� a otrzyman� z sieci
    numRecognized(i) = 500 - recognized;    % okre�lenie ile cyfr rozpoznano
end

figure
plot(variation,numRecognized);  % tworzenie wykresu przedstawiaj�cego relacja rozpoznanych cyfr do poziomu ich zaszumienia
str = sprintf('Liczba rozpoznanych cyfr (poziom szumu zestawu ucz�cego: %f)',noise);
title(str);
xlabel('Wariancja rozk�adu normalnego (poziom szumu)');
ylabel('Rozpoznane cyfry (z 500)');

%%
net = network;
end
