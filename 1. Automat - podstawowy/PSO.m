function [  ] = PSO(s_cnt, d_cnt,t_mtx)

% Inicjalizacja œrodowiska:
pCount = 32; % Liczba cz¹stek
maxIterations = 1000; % Liczba maksymalnych iteracji, jak¹ wykona funkcja
gBest = 1; % Globalne minimum pocz¹tkowe

% Inicjalizacja cz¹stek,  do ka¿dej cz¹stki przypisujemy:
% - pocz¹tkow¹ pozycjê
% - najlepsza pozycja (to samo co wy¿ej) lub 'gBest' jeœli gBest mniejsze
% - pocz¹tkow¹ prêdkoœæ
M = zeros(s_cnt, s_cnt, d_cnt, pCount);
pBest = zeros(s_cnt, s_cnt, d_cnt, pCount);
for particle = 1:pCount
    M = zeros(s_cnt, s_cnt, d_cnt, particle);
    for i=1:d_cnt
        for j=1:s_cnt
            r=randi(s_cnt);
            M(r,j,i)=1;
        end
    end
    [pBestError, pBestErrorPerc]=ErrorFunction2(M(:,:,:,particle),t_mtx);
    if(pBestErrorPerc<gBest)
       gBest=pBestErrorPerc;
    end
    pBest(:,:,:,particle)=M(:,:,:,particle);
    %dodanie predkosci poczatkowej czastek
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

