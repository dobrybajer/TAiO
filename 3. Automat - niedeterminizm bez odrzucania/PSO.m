function [b_mtx, be_proc] = PSO(s_cnt, d_cnt, mtx, maxIterations, pCount, wspol, u_bnd, c1, c2)

% Inicjalizacja œrodowiska:
gBestValue = 2; % Globalne minimum pocz¹tkowe
pBestValue=ones(pCount,1);
l_bnd=0;

% Inicjalizacja cz¹stek,  do ka¿dej cz¹stki przypisujemy:
% - pocz¹tkow¹ pozycjê
% - najlepsza pozycja (to samo co wy¿ej) lub 'gBest' jeœli gBest mniejsze
% - pocz¹tkow¹ prêdkoœæ

vu_bnd=wspol*abs(u_bnd-l_bnd);
vl_bnd=-vu_bnd;


pBest = zeros(s_cnt, s_cnt, d_cnt, pCount);
X=pBest;
V=pBest;
for i = 1:pCount
    X(:,:,:,i) = (u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt) + l_bnd;
    pBest(:,:,:,i)=X(:,:,:,i);
    V(:,:,:,i) = (vu_bnd-vl_bnd).*rand(s_cnt, s_cnt, d_cnt) + vl_bnd;
    [~, pBestErrorPerc, o_mtx]=ErrorFunction(mtx,X(:,:,:,i),1);
    if(pBestErrorPerc<gBestValue)
       gBestValue=pBestErrorPerc;
       gBest=X(:,:,:,i);
       gBestRecreated=o_mtx;
    end
    pBestValue(i,1)=pBestErrorPerc;
end

% G³ówna pêtla funkcji. Wykonuje siê nie wiêcej ni¿ 'maxIter' razy, ale
% tak¿e mo¿e zostaæ zakoñczona wczeœniej, jeœli spe³nione jest kryterium
% znalezienia wystarczaj¹co dobrego rozwi¹zania (tzn. ¿e kolejne zmiany s¹
% niewiele polepszaj¹ce rozwi¹zanie) AKTUALNIE BRAK Z POWODÓW TECHNICZNYCH
% - funkcje s¹ dyskretyzowane
for iteration=1:maxIterations
    tic
    for i = 1:pCount
        V(:,:,:,i)=wspol.*V(:,:,:,i)+c1.*rand().*(pBest(:,:,:,i)-X(:,:,:,i))-c2.*rand().*(gBest-X(:,:,:,i));
        X(:,:,:,i)=X(:,:,:,i)+V(:,:,:,i);

        [~, pBestErrorPerc,o_mtx]=ErrorFunction(mtx,X(:,:,:,i),1);
        if(pBestErrorPerc<pBestValue(i,1))
           pBestValue(i,1)=pBestErrorPerc;
           pBest(:,:,:,i)=X(:,:,:,i);
           if(pBestErrorPerc<gBestValue)
               gBestValue=pBestErrorPerc;
               gBest=X(:,:,:,i);
               gBestRecreated=o_mtx;
           end
        end
    end
    disp(['W iteracji: ' num2str(iteration) ', b³¹d wynosi: ' num2str(gBestValue*100,2) '%']);
    elapsedTime=toc;
    disp(['Czas dzia³ania iteracji: ' num2str(elapsedTime,3) ' sekund(y)']);
    disp(' ');
end

b_mtx=gBestRecreated;
be_proc=gBestValue;
end

