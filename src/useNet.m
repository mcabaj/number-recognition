function answer = useNet(network,data)
%% 
%  ANSWER = USE_NET(NET,DATA)
%  Inputs :
%    NETWORK - sie� do kt�rej zostanie wprowadzony wektor wej��
%    reprezentuj�cy cyfr�
%    DATA - macierz o wymiarze 35x1 obrazuj�ca cyfr� w postaci bitmapy o
%    wymiarach 7x5 
%  Returns:
%    ANSWER - odpowied� sieci, kt�ra cyfra zosta�a rozpoznana

% Marek Cabaj & Kamil Kr�l
% 03-04-2012


%%
S = size(data);  
counter = 0;    % licznik pomocniczy

if (S(1) == 35 && S(2) == 1)    % sprawdzanie wymiar�w macierzy
    Y = network(data);  % wprowadzenie danych do sieci i przypisanie odpowiedzi sieci do Y
    figure
    plotchar(data)
    for i = 1:10
        if Y(i) < 0.8   % je�eli odpowied� sieci jest mniejsza od 0.8 uwa�ana jest za niedostatecznie siln�
            Y(i) = 0;   % zerujemy tak� odpowied�
            counter = counter+1;    % zliczamy ilo�� za s�abych sygna��w wyj�ciowych
        end
    end
    if counter == 10    % wszystkie odpowiedzi by�y na tyle s�abe, �e mo�na uzna� cyfr� jako nierozpoznan�
        answer = 'Cyfra nie rozpoznana';
    else
        Y = compet(Y);  % funkcja compet zeruje wszystkie elementy wektora Y opr�cz najwi�kszego, kt�ry zamienia na '1'
        pos = find(Y==1);   % ustalenie pozycji elementu najwi�kszego
        answer = pos-1;     % przypisanie odpowiedniej cyfry jako odpowiedzi ('-1' poniewa� cyfry s� od zera)
    end
else    % w przypadku kiedy macierz nie posiada wymaganych wymiar�w
    answer = 'Zly wymiar macierzy z danymi';
    
end

