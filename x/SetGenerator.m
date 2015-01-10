function [l_set, t_set] = SetGenerator(s_cnt, c_cnt, a_cnt, d_cnt, l_bnd, u_bnd, mu, s, procRozmZaburz)
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
    global etap;
    stranger_cnt=0;
    if (strcmp(etap,'a1') || strcmp(etap,'a3'))
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
        n_set=normrnd(mu,s,s_cnt*c_cnt,a_cnt); % zbiór warto?ci wylosowany rozk?adem gaussa (warto?? oczekiwana i odchylenie parametryzowane)
        l_set=abs(l_set+n_set); % zbiór cech zaburzony szumem z rozk?adu gaussa (warto?ci macierzy n_set), warto?ci wi?ksze b?d? równe 0
        l_set = ManageSet(l_set, d_cnt, l_bnd, u_bnd);
        l_set=cat(2,s_list,l_set); % dodanie kolumny symboli
    elseif (strcmp(etap,'a2') || strcmp(etap,'a4'))
        w_smax=floor(s_cnt*c_cnt*(procRozmZaburz/100));
        stranger_cnt=randi(floor(w_smax));
   
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
        l_set = ManageSet(l_set, d_cnt, l_bnd, u_bnd);
        l_set=cat(2,s_list,l_set); % dodanie kolumny symboli
    elseif strcmp(etap,'a5')
        %wektor symboli
        symbols_arr = zeros(s_cnt*c_cnt,1);
        symbol_tmp = 1;
        for i=1:length(symbols_arr)
            symbols_arr(i) = symbol_tmp;
            if(mod(i,c_cnt) == 0)
                symbol_tmp = symbol_tmp + 1;
            end
        end

        %zbiór ucz?cy
        l_set_tmp = normrnd(mu, s, s_cnt, a_cnt); 
        for i = 1:s_cnt
            for j = 1:c_cnt
                l_set((i-1)*c_cnt + j, :) = l_set_tmp(i,:);
            end
        end

        %zbiór wartoœci wylosowany rozk³adem gaussa (wartoœæ oczekiwana i odchylenie parametryzowane)
        n_set = normrnd(mu, s, s_cnt*c_cnt, a_cnt); 
        l_set = l_set + n_set;

        %-------normalizacja------%
        max_arr = max(l_set);
        max_el = max(max_arr);
        l_set = l_set./max_el;
        l_set = abs(l_set);
        %-------------------------%


        %--podzial na przedzia³y--%
        %l_set = ceil(l_set.*d_cnt);
        section = 1/d_cnt;
        final_set = ones(size(l_set,1), a_cnt, d_cnt);

        f_gauss = @(x,x0)  exp(-((x-x0)*(x-x0)));
        %f_gauss
        for i = 1:size(l_set,1)
            for j = 1:a_cnt
                arg1 = l_set(i,j);
                for k = 1:d_cnt
                    arg2 = (k-1) * section + section/2;
                    final_set(i,j,k) = f_gauss(arg1,arg2);
                end
            end
        end
        %-------------------------%


        %z?o?enie z symbolami do pierwszej kolumny 
        symbols_mtx = zeros(size(final_set, 1), 1, size(final_set,3));
        symbols_mtx(:,1,1) = symbols_arr;
        final_set = cat(2,symbols_mtx, final_set);

        for i=2:size(final_set,3)
            final_set(:,1,i) = final_set(:,1,1);
        end
        l_set=final_set;
    end
   
    t_set = TrainingSetGenerator(s_cnt, c_cnt, l_set, stranger_cnt);
    
end

