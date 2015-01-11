function [b_mtx, be_proc] = PSO(s_cnt, d_cnt, mtx, maxIterations, pCount, wspol, u_bnd, c1, c2, log, fcHandle)

%_____________Inicjalizacja œrodowiska:__________________
global etap;
gplot=zeros(1,maxIterations);   % Wektor b³êdów poszczególnych iteracji
gBestValue = 2;                 % Globalne minimum pocz¹tkowe
pBestValue=ones(pCount,1);      % Wektor najlepszych dotychczasowo b³êdów dla ka¿dej cz¹stki
l_bnd=0;                        % Ograniczenie dolne search space cz¹stki
vel_factor=0.2*abs(u_bnd-l_bnd);% Wspó³czynnik prêdkoœci w stosunku do dziedziny search space
max_vel=0.5*abs(u_bnd-l_bnd);   % Maksymalna prêdkoœæ jak¹ osi¹gn¹ cz¹stki
pBest = zeros(s_cnt, s_cnt, d_cnt, pCount); % Wektor macierzy trójwymiarowych okreœlaj¹cy najlepszy automat dla ka¿dej cz¹stki w danym etapie obliczenia
X=pBest;                                    % Wektor macierzy trójwymiarowych okreœlaj¹cy aktualne automaty (macierz przejœcia) dla ka¿dej cz¹stki
V=pBest;                                    % Wektor macierzy trójwymiarowych okreœlaj¹cy aktualne macierze prêdkoœci danej cz¹stki
%________________________________________________________

% Inicjalizacja cz¹stek, do ka¿dej cz¹stki przypisujemy:
% - pocz¹tkow¹ pozycjê
% - najlepsza pozycja (to samo co wy¿ej)
% - pocz¹tkow¹ prêdkoœæ

for i = 1:pCount
    X(:,:,:,i) = (u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt) + l_bnd;
    V(:,:,:,i) = ((u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt) + l_bnd)*vel_factor;
    pBest(:,:,:,i)=X(:,:,:,i);
    
    [~, pBestErrorPerc, o_mtx]=fcHandle(mtx,X(:,:,:,i),1);
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

for iteration=1:maxIterations
    if(log==1)
        startIteration=tic;
    end
    
    for i = 1:pCount
        Vn=wspol.*V(:,:,:,i)+c1.*rand().*(pBest(:,:,:,i)-X(:,:,:,i))+c2.*rand().*(gBest-X(:,:,:,i));
        Vn(Vn>max_vel)=max_vel;
        Vn(Vn<-max_vel)=-max_vel;
        V(:,:,:,i)=Vn;
        
        Xn=X(:,:,:,i)+V(:,:,:,i);
        Xn(Xn>u_bnd)=u_bnd;
        Xn(Xn<l_bnd)=l_bnd;
        X(:,:,:,i)=Xn;

        [~, pBestErrorPerc, o_mtx]=fcHandle(mtx,X(:,:,:,i),1);
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
    
    gplot(1,iteration)=gBestValue;
    
    if(log==1)
        PrintInfo(3,[iteration gBestValue toc(startIteration)]);
    end
end
h = figure;

plot(gplot);
axis([1,maxIterations,0,1]);
title(['etap ' etap ' iloœæ klas ' num2str(s_cnt)]);
print(h, '-dpsc', strcat('C:\Users\Kamil\Desktop\',num2str(etap),num2str(maxIterations)));
% Zwrócenie odpowiedniej macierzy dla ka¿dego z etapów
if (strcmp(etap,'a3') || strcmp(etap,'a4'))
    b_mtx=gBestRecreated;
elseif (strcmp(etap,'a1') || strcmp(etap,'a2'))
    b_mtx=AutomataRecreator(gBest);
else
    b_mtx=gBest;
end
be_proc=gBestValue;
end