function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu (pocz�tkowe warto�ci), w ka�dej kolumnie dok�adnie jedna 1, rozmiar macierzy (s_cnt+1,s_cnt+1,d_cnt) 
%ostatni element w kolumnie (stan gdzie 1 jest na ostatnim miejscu)
%rozpoznanie elementu obcego 
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przej�cia; macierz 3D)

    M = zeros(s_cnt+1, s_cnt+1, d_cnt);

    for i=1:d_cnt
        for j=1:s_cnt+1
            r=randi(s_cnt+1);
            M(r,j,i)=1;
        end
    end
end

