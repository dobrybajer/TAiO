function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu rozmytego (pocz�tkowe warto�ci), rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przej�cie; macierz 3D)
   
    M = rand(s_cnt, s_cnt, d_cnt); % by� mo�e to wystarczy
end

