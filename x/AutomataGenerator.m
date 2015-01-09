function M = AutomataGenerator(s_cnt, d_cnt, flaga)
%AUTOMATAGENERATOR Tworzenie losowego automatu (pocz�tkowe warto�ci), je�li
%flaga r�wna:
%1 - w ka�dej kolumnie dok�adnie jedna 1, rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
%2 - w ka�dej kolumnie dok�adnie jedna 1, rozmiar macierzy (s_cnt+1,s_cnt+1,d_cnt) 
%ostatni element w kolumnie (stan gdzie 1 jest na ostatnim miejscu)
%rozpoznanie elementu obcego 
%3 - w ka�dej kolumnie od 0 do 3 jedynek, rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
%4 - w ka�dej kolumnie od 0 do 3 jedynek, rozmiar macierzy (s_cnt+1,s_cnt+1,d_cnt) 
%ostatni element w kolumnie (stan gdzie 1 jest na ostatnim miejscu)
%rozpoznanie elementu obcego 
%5 - rozmiar macierzy (s_cnt,s_cnt,d_cnt), automat rozmyty
%6 - rozmiar macierzy (s_cnt,s_cnt,d_cnt), automat rozmyty
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przej�cie; macierz 3D)

    if flaga == 1 || flaga == 3 || flaga == 5
        M = zeros(s_cnt, s_cnt, d_cnt);
    else
        M = zeros(s_cnt+1, s_cnt+1, d_cnt);
        return;
    end

    if flaga == 1
         for i=1:d_cnt
            for j=1:s_cnt
                r=randi(s_cnt);
                M(r,j,i)=1;
            end
        end
    elseif flaga == 2
        for i=1:d_cnt
            for j=1:s_cnt+1
                r=randi(s_cnt+1);
                M(r,j,i)=1;
            end
        end
    elseif flaga == 3
        for i=1:d_cnt
            for j=1:s_cnt
                places=randperm(s_cnt,randi([0 3],1));
                M(places,j,i)=1; 
            end
        end
    elseif flaga == 4
        for i=1:d_cnt
            for j=1:s_cnt+1
                places=randperm(s_cnt+1,randi([0 3],1));
                M(places,j,i)=1; 
            end
        end
    end
end

