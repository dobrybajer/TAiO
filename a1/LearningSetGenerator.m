function l_set = LearningSetGenerator(s_cnt, c_cnt, a_cnt, d_cnt, l_bnd, u_bnd, mu, s)
%LEARNINGSETGENERATOR Tworzenie (losowanie) zbioru ucz¹cego oraz zapisanie go do pliku
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentantów klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
%   IN l_bnd  - dolne ograniczenie dla przedzia³u rozkladu jednostajnego
%   IN u_bnd  - górne ograniczenie dla przedzia³u rozk³adu jednostajnego
%   IN mu     - wartoœæ oczekiwana rozk³adu normalnego
%   IN s      - odchylenie standardowe dla rozk³adu normalnego
%   OUT l_set - wygenerowany zbiór ucz¹cy
    s_list=zeros(s_cnt*c_cnt,1);
    counter=1;
    for i=1:length(s_list)
        s_list(i)=counter;
        if mod(i,c_cnt)==0
            counter=counter+1;
        end
    end

    l_set=l_bnd +(u_bnd-l_bnd).*rand(s_cnt*c_cnt, a_cnt); % zbiór cech wylosowany rozk³adem jednostajnym (cala tablica naraz), przedzia³ losowania z parametrów
    %n_set=randn(s_cnt*c_cnt, a_cnt); % zbiór wartoœci wylosowany rozk³adem gaussa (wartoœæ oczekiwana 0, odchylenie 1)
    n_set=normrnd(mu,s,s_cnt*c_cnt,a_cnt); % zbiór wartoœci wylosowany rozk³adem gaussa (wartoœæ oczekiwana i odchylenie parametryzowane)
    l_set=abs(l_set+n_set); % zbiór cech zaburzony szumem z rozk³adu gaussa (wartoœci macierzy n_set), wartoœci wiêksze b¹dŸ równe 0
    l_set = ManageSet(l_set, d_cnt, l_bnd, u_bnd);
    l_set=cat(2,s_list,l_set); % dodanie kolumny symboli
    
    FileWriter('genLearningSet.dat',l_set,';');
end

