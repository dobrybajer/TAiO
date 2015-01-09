function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu rozmytego (pocz¹tkowe wartoœci), rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przejœcie; macierz 3D)
   
    M = rand(s_cnt, s_cnt, d_cnt); % byæ mo¿e to wystarczy
end

