function answer = useNet(network,data)
%% 
%  ANSWER = USE_NET(NET,DATA)
%  Inputs :
%    NETWORK - sieæ do której zostanie wprowadzony wektor wejœæ
%    reprezentuj¹cy cyfrê
%    DATA - macierz o wymiarze 35x1 obrazuj¹ca cyfrê w postaci bitmapy o
%    wymiarach 7x5 
%  Returns:
%    ANSWER - odpowiedŸ sieci, która cyfra zosta³a rozpoznana

% Marek Cabaj & Kamil Król
% 03-04-2012


%%
S = size(data);  
counter = 0;    % licznik pomocniczy

if (S(1) == 35 && S(2) == 1)    % sprawdzanie wymiarów macierzy
    Y = network(data);  % wprowadzenie danych do sieci i przypisanie odpowiedzi sieci do Y
    figure
    plotchar(data)
    for i = 1:10
        if Y(i) < 0.8   % je¿eli odpowiedŸ sieci jest mniejsza od 0.8 uwa¿ana jest za niedostatecznie siln¹
            Y(i) = 0;   % zerujemy tak¹ odpowiedŸ
            counter = counter+1;    % zliczamy iloœæ za s³abych sygna³ów wyjœciowych
        end
    end
    if counter == 10    % wszystkie odpowiedzi by³y na tyle s³abe, ¿e mo¿na uznaæ cyfrê jako nierozpoznan¹
        answer = 'Cyfra nie rozpoznana';
    else
        Y = compet(Y);  % funkcja compet zeruje wszystkie elementy wektora Y oprócz najwiêkszego, który zamienia na '1'
        pos = find(Y==1);   % ustalenie pozycji elementu najwiêkszego
        answer = pos-1;     % przypisanie odpowiedniej cyfry jako odpowiedzi ('-1' poniewa¿ cyfry s¹ od zera)
    end
else    % w przypadku kiedy macierz nie posiada wymaganych wymiarów
    answer = 'Zly wymiar macierzy z danymi';
    
end

