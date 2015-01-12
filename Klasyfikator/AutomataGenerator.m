function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu (pocz¹tkowe wartoœci), jeœli
%flaga równa:
%1 - w ka¿dej kolumnie dok³adnie jedna 1, rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
%2 - w ka¿dej kolumnie dok³adnie jedna 1, rozmiar macierzy (s_cnt+1,s_cnt+1,d_cnt) 
%ostatni element w kolumnie (stan gdzie 1 jest na ostatnim miejscu)
%rozpoznanie elementu obcego 
%3 - w ka¿dej kolumnie od 0 do 3 jedynek, rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
%4 - w ka¿dej kolumnie od 0 do 3 jedynek, rozmiar macierzy (s_cnt+1,s_cnt+1,d_cnt) 
%ostatni element w kolumnie (stan gdzie 1 jest na ostatnim miejscu)
%rozpoznanie elementu obcego 
%5 - rozmiar macierzy (s_cnt,s_cnt,d_cnt), automat rozmyty
%6 - rozmiar macierzy (s_cnt,s_cnt,d_cnt), automat rozmyty
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przejœcie; macierz 3D)
    global etap;   
    global ograniczNietermin;

    if strcmp(etap,'a1') || strcmp(etap,'a3')
        M = zeros(s_cnt, s_cnt, d_cnt);
    elseif strcmp(etap,'a2') || strcmp(etap,'a4')
        M = zeros(s_cnt+1, s_cnt+1, d_cnt);
    else
        M = rand(s_cnt, s_cnt, d_cnt);
    end

    if strcmp(etap,'a1')
         for i=1:d_cnt
            for j=1:s_cnt
                r=randi(s_cnt);
                M(r,j,i)=1;
            end
        end
    elseif strcmp(etap,'a2')
        for i=1:d_cnt
            for j=1:s_cnt+1
                r=randi(s_cnt+1);
                M(r,j,i)=1;
            end
        end
    elseif strcmp(etap,'a3')
        for i=1:d_cnt
            for j=1:s_cnt
                niedeterminizm=floor(ograniczNietermin/100*s_cnt);
                %places=randperm(s_cnt,randi([0 niedeterminizm],1));
                 places = randperm(s_cnt);
                 places = places(1:randi([0 niedeterminizm],1));
                M(places,j,i)=1; 
            end
        end
    elseif strcmp(etap,'a4')
        for i=1:d_cnt
            for j=1:s_cnt+1
                niedeterminizm=floor(ograniczNietermin/100*(s_cnt+1));
               % places=randperm(s_cnt+1,randi([0 niedeterminizm],1));
                 places = randperm(s_cnt+1);
                 places = places(1:randi([0 niedeterminizm],1));
                M(places,j,i)=1; 
            end
        end
    end
end

