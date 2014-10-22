function [b_mtx, be_proc] = PSO(s_cnt, d_cnt, mtx)

% Inicjalizacja �rodowiska:
pCount = 5; % Liczba cz�stek
maxIterations = 1000; % Liczba maksymalnych iteracji, jak� wykona funkcja
gBestValue = 2; % Globalne minimum pocz�tkowe
pBestValue=ones(pCount,1);
l_bnd=0;
u_bnd=1;
c1=2;
c2=2;
% Inicjalizacja cz�stek,  do ka�dej cz�stki przypisujemy:
% - pocz�tkow� pozycj�
% - najlepsza pozycja (to samo co wy�ej) lub 'gBest' je�li gBest mniejsze
% - pocz�tkow� pr�dko��

vu_bnd=abs(u_bnd-l_bnd);
vl_bnd=-vu_bnd;


pBest = zeros(s_cnt, s_cnt, d_cnt, pCount);
for i = 1:pCount
    X = l_bnd +(u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt, i);
    pBest(:,:,:,i)=X(:,:,:,i);
    V = vl_bnd +(vu_bnd-vl_bnd).*rand(s_cnt, s_cnt, d_cnt, i);
    g_mtx=AutomataRecreator(X(:,:,:,i));
    [~, pBestErrorPerc]=ErrorFunction2(mtx,g_mtx);
    if(pBestErrorPerc<gBestValue)
       gBestValue=pBestErrorPerc;
       gBest=X(:,:,:,i);
       pBestValue(i,1)=pBestErrorPerc;
    end
end

% G��wna p�tla funkcji. Wykonuje si� nie wi�cej ni� 'maxIter' razy, ale
% tak�e mo�e zosta� zako�czona wcze�niej, je�li spe�nione jest kryterium
% znalezienia wystarczaj�co dobrego rozwi�zania (tzn. �e kolejne zmiany s�
% niewiele polepszaj�ce rozwi�zanie)
iteration = 1;
while iteration < maxIterations
    for i = 1:pCount
        V(:,:,:,i)=V(:,:,:,i)+c1.*rand().*(pBest(:,:,:,i)-X(:,:,:,i))+c2.*rand().*(gBest-X(:,:,:,i));
        X(:,:,:,i)=X(:,:,:,i)+V(:,:,:,i);
        
        g_mtx=AutomataRecreator(X(:,:,:,i));
        [~, pBestErrorPerc]=ErrorFunction2(mtx,g_mtx);
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

