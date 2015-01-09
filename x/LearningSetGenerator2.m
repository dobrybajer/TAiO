function l_set = LearningSetGenerator2(s_cnt, c_cnt, a_cnt, d_cnt, l_bnd, u_bnd, mu, s, w_smax)
%LEARNINGSETGENERATOR Tworzenie (losowanie) zbioru ucz¹cego wraz z
%elementami obczymi, których iloœæ jes miêdzy 1 a w_smax * iloœæ symboli *
%iloœæ powtórzeñ symbolu (liczba elementów obcych nie wiêksza ni¿ 25% dla w_smax = 0.25)
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentantów klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
%   IN l_bnd  - dolne ograniczenie dla przedzia³u rozkladu jednostajnego
%   IN u_bnd  - górne ograniczenie dla przedzia³u rozk³adu jednostajnego
%   IN mu     - wartoœæ oczekiwana rozk³adu normalnego
%   IN s      - odchylenie standardowe dla rozk³adu normalnego
%   IN w_smax - maksymalny wspó³czynnik liczby elementów obcych w
%   odniesieniu do liczby wszystkich symboli * iloœæ ich powtórzeñ
%
%   OUT l_set - wygenerowany zbiór ucz¹cy

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
            s_list(i)=-randi([s_cnt+1 c_cnt*s_cnt]); % losowe wartoœci ze znakiem "-"
        end
    end

    l_set=l_bnd +(u_bnd-l_bnd).*rand(s_cnt*c_cnt+stranger_cnt, a_cnt); % zbiór cech wylosowany rozk³adem jednostajnym (cala tablica naraz), przedzia³ losowania z parametrów
    n_set=normrnd(mu,s,s_cnt*c_cnt+stranger_cnt,a_cnt); % zbiór wartoœci wylosowany rozk³adem gaussa (wartoœæ oczekiwana i odchylenie parametryzowane)
    l_set=abs(l_set+n_set); % zbiór cech zaburzony szumem z rozk³adu gaussa (wartoœci macierzy n_set), wartoœci wiêksze b¹dŸ równe 0
    l_set=l_set./(u_bnd-l_bnd); % zaburzony zbiór cech zosta³ znormalizowany do przedzialu [0,1]
    l_set(l_set>=1)=1; % w przypadku, gdy jakieœ elementy po normalizacji bêd¹ > od 1
    l_set=ceil(l_set.*d_cnt); % zamiana wartoœci na przedzia³y, w jakich siê dane wartoœci znajduj¹, w zaleznosci od liczby podzialów
    l_set=cat(2,s_list,l_set); % dodanie kolumny symboli
    
end