function M = AutomataGenerator(s_cnt, d_cnt)
%AUTOMATAGENERATOR Tworzenie losowego automatu (pocz�tkowe warto�ci), w ka�dej kolumnie dok�adnie jedna 1, rozmiar macierzy (s_cnt,s_cnt,d_cnt) 
% IN s_cnt - liczba symboli
% IN d_cnt - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
% OUT M     - wygenerowany automat (funkcja przej�cie; macierz 3D)

    M = zeros(s_cnt, s_cnt, d_cnt);

    for i=1:d_cnt
        for j=1:s_cnt
            r=randi(s_cnt);
            M(r,j,i)=1;
        end
    end
end

