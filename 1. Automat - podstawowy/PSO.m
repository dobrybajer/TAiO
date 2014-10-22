function [  ] = PSO(s_cnt, d_cnt,t_mtx)

% Inicjalizacja �rodowiska:
pCount = 32; % Liczba cz�stek
maxIterations = 1000; % Liczba maksymalnych iteracji, jak� wykona funkcja
gBest = 1; % Globalne minimum pocz�tkowe

% Inicjalizacja cz�stek,  do ka�dej cz�stki przypisujemy:
% - pocz�tkow� pozycj�
% - najlepsza pozycja (to samo co wy�ej) lub 'gBest' je�li gBest mniejsze
% - pocz�tkow� pr�dko��
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

