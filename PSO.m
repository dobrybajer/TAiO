function [ output_args ] = PSO( input_args )

% Inicjalizacja �rodowiska:
pCount = 32; % Liczba cz�stek
maxIterations = 1000; % Liczba maksymalnych iteracji, jak� wykona funkcja
gBest = 100000; % Globalne minimum pocz�tkowe

% Inicjalizacja cz�stek,  do ka�dej cz�stki przypisujemy:
% - pocz�tkow� pozycj�
% - najlepsza pozycja (to samo co wy�ej) lub 'gBest' je�li gBest mniejsze
% - pocz�tkow� pr�dko��
for particle = 1:pCount
    
end



% G��wna p�tla funkcji. Wykonuje si� nie wi�cej ni� 'maxIter' razy, ale
% tak�e mo�e zosta� zako�czona wcze�niej, je�li spe�nione jest kryterium
% znalezienia wystarczaj�co dobrego rozwi�zania (tzn. �e kolejne zmiany s�
% niewiele polepszaj�ce rozwi�zanie)
iteration = 1;
while iteration < maxIterations % or sth else...
    for particle = 1:pCount
    
    end
end

end

