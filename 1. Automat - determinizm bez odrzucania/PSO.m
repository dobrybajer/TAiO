function [b_mtx, be_proc] = PSO(s_cnt, d_cnt, mtx, maxIterations, pCount, wspol, u_bnd, c1, c2)

% Inicjalizacja �rodowiska:
gBestValue = 2; % Globalne minimum pocz�tkowe
pBestValue=ones(pCount,1);
l_bnd=0;

% Inicjalizacja cz�stek,  do ka�dej cz�stki przypisujemy:
% - pocz�tkow� pozycj�
% - najlepsza pozycja (to samo co wy�ej) lub 'gBest' je�li gBest mniejsze
% - pocz�tkow� pr�dko��

vu_bnd=wspol*abs(u_bnd-l_bnd);
vl_bnd=-vu_bnd;


pBest = zeros(s_cnt, s_cnt, d_cnt, pCount);
X=pBest;
V=pBest;
for i = 1:pCount
    X(:,:,:,i) = (u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt) + l_bnd;
    pBest(:,:,:,i)=X(:,:,:,i);
    V(:,:,:,i) = (vu_bnd-vl_bnd).*rand(s_cnt, s_cnt, d_cnt) + vl_bnd;
    [~, pBestErrorPerc]=ErrorFunction(mtx,X(:,:,:,i));
    if(pBestErrorPerc<gBestValue)
       gBestValue=pBestErrorPerc;
       gBest=X(:,:,:,i);
    end
    pBestValue(i,1)=pBestErrorPerc;
end

% G��wna p�tla funkcji. Wykonuje si� nie wi�cej ni� 'maxIter' razy, ale
% tak�e mo�e zosta� zako�czona wcze�niej, je�li spe�nione jest kryterium
% znalezienia wystarczaj�co dobrego rozwi�zania (tzn. �e kolejne zmiany s�
% niewiele polepszaj�ce rozwi�zanie) AKTUALNIE BRAK Z POWOD�W TECHNICZNYCH
% - funkcje s� dyskretyzowane
iteration = 1;
while iteration < maxIterations
    for i = 1:pCount
        V(:,:,:,i)=wspol.*V(:,:,:,i)+c1.*rand().*(pBest(:,:,:,i)-X(:,:,:,i))-c2.*rand().*(gBest-X(:,:,:,i));
        X(:,:,:,i)=X(:,:,:,i)+V(:,:,:,i);

        [~, pBestErrorPerc]=ErrorFunction(mtx,X(:,:,:,i));
        if(pBestErrorPerc<pBestValue(i,1))
           pBestValue(i,1)=pBestErrorPerc;
           pBest(:,:,:,i)=X(:,:,:,i);
           if(pBestErrorPerc<gBestValue)
               gBestValue=pBestErrorPerc;
               gBest=X(:,:,:,i);
           end
        end
    end
    iteration=iteration+1;
end

b_mtx=AutomataRecreator(gBest);
be_proc=gBestValue;
end

