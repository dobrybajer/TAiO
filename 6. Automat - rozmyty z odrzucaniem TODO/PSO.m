function [b_mtx, be_proc] = PSO(s_cnt, d_cnt, mtx, maxIterations, pCount, wspol, u_bnd, c1, c2, log)

%_____________Inicjalizacja �rodowiska:__________________
gplot=zeros(1,maxIterations);   % Wektor b��d�w poszczeg�lnych iteracji
gBestValue = 2;                 % Globalne minimum pocz�tkowe
pBestValue=ones(pCount,1);      % Wektor najlepszych dotychczasowo b��d�w dla ka�dej cz�stki
l_bnd=0;                        % Ograniczenie dolne search space cz�stki
vel_factor=0.2*abs(u_bnd-l_bnd);% Wsp�czynnik pr�dko�ci w stosunku do dziedziny search space
max_vel=0.5*abs(u_bnd-l_bnd);   % Maksymalna pr�dko�� jak� osi�gn� cz�stki
pBest = zeros(s_cnt, s_cnt, d_cnt, pCount); % Wektor macierzy tr�jwymiarowych okre�laj�cy najlepszy automat dla ka�dej cz�stki w danym etapie obliczenia
X=pBest;                                    % Wektor macierzy tr�jwymiarowych okre�laj�cy aktualne automaty (macierz przej�cia) dla ka�dej cz�stki
V=pBest;                                    % Wektor macierzy tr�jwymiarowych okre�laj�cy aktualne macierze pr�dko�ci danej cz�stki
%________________________________________________________

% Inicjalizacja cz�stek, do ka�dej cz�stki przypisujemy:
% - pocz�tkow� pozycj�
% - najlepsza pozycja (to samo co wy�ej)
% - pocz�tkow� pr�dko��

for i = 1:pCount
    X(:,:,:,i) = (u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt) + l_bnd;
    V(:,:,:,i) = ((u_bnd-l_bnd).*rand(s_cnt, s_cnt, d_cnt) + l_bnd)*vel_factor;
    pBest(:,:,:,i)=X(:,:,:,i);
    
    [~, pBestErrorPerc]=ErrorFunction(mtx,X(:,:,:,i),d_cnt);
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

        [~, pBestErrorPerc]=ErrorFunction(mtx,X(:,:,:,i), d_cnt);
        if(pBestErrorPerc<pBestValue(i,1))
           pBestValue(i,1)=pBestErrorPerc;
           pBest(:,:,:,i)=X(:,:,:,i);
           if(pBestErrorPerc<gBestValue)
               gBestValue=pBestErrorPerc;
               gBest=X(:,:,:,i);
           end
        end
    end
    
    gplot(1,iteration)=gBestValue;
    
    if(log==1)
        PrintInfo(3,[iteration gBestValue toc(startIteration)]);
    end
end

plot(gplot);
axis([1,maxIterations,0,1]);

b_mtx=gBest;
be_proc=gBestValue;
end

