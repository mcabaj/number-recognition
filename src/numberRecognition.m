function net = numberRecognition(noise)
%% Funkcja, która tworzy, konfiguruje, trenuje oraz testuje sieæ neuronow¹
% stworzon¹ do rozpoznawania cyfr
%
%  NET = NUMBER_RECOGNITION()
%  Inputs:
%    NOISE - liczba okreœlaj¹ca poziom zaszumienia (odpowiada wariancji przy
%    generowaniu liczb losowych z rozk³adu normalnego) zestawu ucz¹cego
%  Returns:
%    NET - stworzona przez funkcje sieæ s³u¿¹ca do rozpoznawania cyfr
%
% Marek Cabaj & Kamil Król
% 03.04.2012



%% Tworzenie zestawu danych do uczenia 
[perfect_X,perfect_T] = learnData(); % u¿ycie funkcji learn_data() w celu otrzymania zestawu 
                      % dziesiêciu idealnie utworzonych cyfr (X) wraz z zestawem  
                      % poprawnych odpowiedzi dla sieci (T)

N = 20; % liczba kopii zestawu danych które zostan¹ poddane deformacji
deformed_X = repmat(perfect_X,1,N); % tworzenie N-kopii zestawu danych X
deformed_X = deformed_X +random('Normal',0,noise,35,10*N); % deformacja wszystkich kopii 
% losowe liczby powstaj¹ z rozk³adu normalnego ze œredni¹=0.0 oraz
% wariancj¹=noise, rozmiar macierzy liczb losowych to 35x(10*N)
deformed_X = max(deformed_X,0); % wszystkie pola mniejsze od 0 s¹ zast¹piane przez 0 
deformed_X = min(deformed_X,1); % wszystkie pola wiêksze od 1 s¹ zast¹piane przez 1

deformed_T = repmat(perfect_T,1,N); % tworzenie N-kopii odpowiedzi T (zostaj¹ dopasowane do zestawu deformed_X)

X = [perfect_X,deformed_X]; % ostateczny zestaw ucz¹cy zawiera idealne cyfry oraz zdeformowane kopie cyfr
T = [perfect_T,deformed_T]; % zestaw odpowiedzi jest dopasowany do zestawu ucz¹cego

%% Tworzenie sieci neuronowej
network = feedforwardnet(20);   % tworzenie sieci neuronowej typu feedforward z 20 neuronami

%% Konfigurowanie sieci
network.divideFcn = '';       % wy³¹czenie funkcji dziel¹cej zestaw danych na Train/Validate/Test
network.initFcn = 'initlay';  % ustawienie funkcji, która  inicjalizuje wagi i bias'y 

%% Inicjalizacja wagi i bias'ów
network = init(network);     % inicjalizacja sieci neuronowej

%% Trenowanie sieci
network = train(network,X,T);   % trenowanie sieci

%% Testowanie sieci
testN = 50; %liczba kopii zestawu danych który bêdzie s³u¿y³ do testowania sieci
pT = eye(10);  %tworzenie macierzy jednostkowej 10x10
pT = repmat(pT,1,testN); %tworzenie N-kopii macierzy jednostkowej

variation = 0:0.01:1;   % kolejne poziomy wariancji rozk³adu normlanego (szum)
iterations = length(variation); % liczba poziomów szumu
numRecognized = zeros(1,iterations);  % tabela rozpoznanych cyfr w kolejnych iteracjach

for i = 1:iterations
    test_X = min(max(repmat(perfect_X,1,testN)+random('Normal',0,variation(i),35,10*testN),0),1);
    test_T = network(test_X);   % tworzenie zaszumionych danych - analogicznie do zestawu ucz¹cego
    test_T
    recognized = pT-compet(test_T); 
    recognized = abs(recognized);
    recognized = sum(sum(recognized))/2;    % sumowanie wszystkich ró¿nic pomiêdzy odpowiedzi¹ wzorcow¹ a otrzyman¹ z sieci
    numRecognized(i) = 500 - recognized;    % okreœlenie ile cyfr rozpoznano
end

figure
plot(variation,numRecognized);  % tworzenie wykresu przedstawiaj¹cego relacja rozpoznanych cyfr do poziomu ich zaszumienia
str = sprintf('Liczba rozpoznanych cyfr (poziom szumu zestawu ucz¹cego: %f)',noise);
title(str);
xlabel('Wariancja rozk³adu normalnego (poziom szumu)');
ylabel('Rozpoznane cyfry (z 500)');

%%
net = network;
end
