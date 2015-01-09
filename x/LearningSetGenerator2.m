function l_set = LearningSetGenerator2(s_cnt, c_cnt, a_cnt, d_cnt, l_bnd, u_bnd, mu, s, w_smax)
%LEARNINGSETGENERATOR Tworzenie (losowanie) zbioru ucz�cego wraz z
%elementami obczymi, kt�rych ilo�� jes mi�dzy 1 a w_smax * ilo�� symboli *
%ilo�� powt�rze� symbolu (liczba element�w obcych nie wi�ksza ni� 25% dla w_smax = 0.25)
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentant�w klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
%   IN l_bnd  - dolne ograniczenie dla przedzia�u rozkladu jednostajnego
%   IN u_bnd  - g�rne ograniczenie dla przedzia�u rozk�adu jednostajnego
%   IN mu     - warto�� oczekiwana rozk�adu normalnego
%   IN s      - odchylenie standardowe dla rozk�adu normalnego
%   IN w_smax - maksymalny wsp�czynnik liczby element�w obcych w
%   odniesieniu do liczby wszystkich symboli * ilo�� ich powt�rze�
%
%   OUT l_set - wygenerowany zbi�r ucz�cy

    stranger_cnt=randi(floor(s_cnt*c_cnt*w_smax));
    s_list=zeros(s_cnt*c_cnt+stranger_cnt,1);
    counter=1;
    for i=1:length(s_list)
        if(i<=s_cnt*c_cnt)
            s_list(i)=counter;
            if mod(i,c_cnt)==0
                counter=counter+1;
            end
        else
            s_list(i)=-randi([s_cnt+1 c_cnt*s_cnt]); % losowe warto�ci ze znakiem "-"
        end
    end

    l_set=l_bnd +(u_bnd-l_bnd).*rand(s_cnt*c_cnt+stranger_cnt, a_cnt); % zbi�r cech wylosowany rozk�adem jednostajnym (cala tablica naraz), przedzia� losowania z parametr�w
    n_set=normrnd(mu,s,s_cnt*c_cnt+stranger_cnt,a_cnt); % zbi�r warto�ci wylosowany rozk�adem gaussa (warto�� oczekiwana i odchylenie parametryzowane)
    l_set=abs(l_set+n_set); % zbi�r cech zaburzony szumem z rozk�adu gaussa (warto�ci macierzy n_set), warto�ci wi�ksze b�d� r�wne 0
    l_set=l_set./(u_bnd-l_bnd); % zaburzony zbi�r cech zosta� znormalizowany do przedzialu [0,1]
    l_set(l_set>=1)=1; % w przypadku, gdy jakie� elementy po normalizacji b�d� > od 1
    l_set=ceil(l_set.*d_cnt); % zamiana warto�ci na przedzia�y, w jakich si� dane warto�ci znajduj�, w zaleznosci od liczby podzial�w
    l_set=cat(2,s_list,l_set); % dodanie kolumny symboli
    
end