function [final_set] = LearningSetGenerator(s_cnt, c_cnt, a_cnt, d_cnt, mu, s)
%LearningFuzzySetGenerator Tworzenie rozmytego zbioru ucz¹cego z elementami
%obcymi
%   IN datafile - plik wejœciowy
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentantów klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia?ów
%   IN mu     - wartoœæ oczekiwana rozk³adu normalnego
%   IN s      - odchylenie standardowe dla rozk³adu normalnego
%   OUT l_set - wygenerowany zbiór ucz¹cy

    %wczytanie macierzy z danych wejœciowych
    %in_mtx = csvread(datafilename, 0, 0);
    
    %wektor symboli
    symbols_arr = zeros(s_cnt*c_cnt,1);
    symbol_tmp = 1;
    for i=1:length(symbols_arr)
        symbols_arr(i) = symbol_tmp;
        if(mod(i,c_cnt) == 0)
            symbol_tmp = symbol_tmp + 1;
        end
    end

    %zbiór ucz¹cy
    l_set = ones(s_cnt*c_cnt, a_cnt);
    
    %zbiór wartoœci wylosowany rozk³adem gaussa (wartoœæ oczekiwana i odchylenie parametryzowane)
    l_set = normrnd(mu, s, s_cnt*c_cnt, a_cnt); 
    
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
end
