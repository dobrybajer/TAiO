function [ output_args ] = PSO( input_args )

% Inicjalizacja œrodowiska:
pCount = 32; % Liczba cz¹stek
maxIterations = 1000; % Liczba maksymalnych iteracji, jak¹ wykona funkcja
gBest = 100000; % Globalne minimum pocz¹tkowe

% Inicjalizacja cz¹stek,  do ka¿dej cz¹stki przypisujemy:
% - pocz¹tkow¹ pozycjê
% - najlepsza pozycja (to samo co wy¿ej) lub 'gBest' jeœli gBest mniejsze
% - pocz¹tkow¹ prêdkoœæ
for particle = 1:pCount
    
end



% G³ówna pêtla funkcji. Wykonuje siê nie wiêcej ni¿ 'maxIter' razy, ale
% tak¿e mo¿e zostaæ zakoñczona wczeœniej, jeœli spe³nione jest kryterium
% znalezienia wystarczaj¹co dobrego rozwi¹zania (tzn. ¿e kolejne zmiany s¹
% niewiele polepszaj¹ce rozwi¹zanie)
iteration = 1;
while iteration < maxIterations % or sth else...
    for particle = 1:pCount
    
    end
end

end

