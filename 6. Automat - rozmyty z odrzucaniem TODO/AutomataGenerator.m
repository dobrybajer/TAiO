function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu niedeterministycznego (pocz�tkowe warto�ci), w ka�dej kolumnie od 0 do 3 jedynek, rozmiar macierzy (s_cnt+1,s_cnt+1,d_cnt) 
%ostatni element w kolumnie (stan gdzie 1 jest na ostatnim miejscu)
%rozpoznanie elementu obcego 
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przej�cia; macierz 3D)
   
    M = rand(s_cnt+1, s_cnt+1, d_cnt); % prawdopodobnie to wystarczy
end

