function [ l_set ] = TrainingSetGenerator(s_cnt, c_cnt, a_cnt, d_cnt, l_bnd, u_bnd, mu, s)
%LEARNINGSETGENERATOR Tworzenie (losowanie) zbioru ucz�cego oraz zapisanie go do pliku
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentant�w klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
%   IN l_bnd  - dolne ograniczenie dla przedzia�u rozkladu jednostajnego
%   IN u_bnd  - g�rne ograniczenie dla przedzia�u rozk�adu jednostajnego
%   IN mu     - warto�� oczekiwana rozk�adu normalnego
%   IN s      - odchylenie standardowe dla rozk�adu normalnego
%   OUT l_set - wygenerowany zbi�r ucz�cy

    s_list=zeros(s_cnt*c_cnt,1);
    counter=1;
    for i=1:length(s_list)
        s_list(i)=counter;
        if mod(i,c_cnt)==0
            counter=counter+1;
        end
    end
    
    l_set=zeros(s_cnt*c_cnt, a_cnt);
    
    x=l_bnd +(u_bnd-l_bnd).*rand(s_cnt,a_cnt);
    for i=1:s_cnt
        for j=1:c_cnt
            l_set((i-1)*c_cnt+j,:) = x(i,:);
        end
    end
    n_set=normrnd(mu,s,s_cnt*c_cnt,a_cnt); % zbi�r warto�ci wylosowany rozk�adem gaussa (warto�� oczekiwana i odchylenie parametryzowane)
    l_set=abs(l_set+n_set); % zbi�r cech zaburzony szumem z rozk�adu gaussa (warto�ci macierzy n_set), warto�ci wi�ksze b�d� r�wne 0
    l_set = ManageSet(l_set, d_cnt, l_bnd, u_bnd);
    l_set=cat(2,s_list,l_set); % dodanie kolumny symboli
end

