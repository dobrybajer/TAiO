function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu niedeterministycznego (pocz�tkowe warto�ci), w ka�dej kolumnie od 0 do 3 jedynek, rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przej�cie; macierz 3D)
   
    M = zeros(s_cnt+1, s_cnt+1, d_cnt+1);

    for i=1:d_cnt+1
        for j=1:s_cnt+1
            places=randperm(s_cnt+1,randi([0 3],1));
            M(places,j,i)=1; 
        end
    end
end

