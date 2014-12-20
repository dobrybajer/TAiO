function final_set = LearningFuzzyForeignElemSetGenerator(datafilename, s_cnt, c_cnt, a_cnt, mu, s)
%LearningFuzzySetGenerator Tworzenie rozmytego zbioru ucz¹cego z elementami
%obcymi
%   IN datafile - plik wejœciowy
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentantów klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN mu     - wartoœæ oczekiwana rozk³adu normalnego
%   IN s      - odchylenie standardowe dla rozk³adu normalnego
%   OUT l_set - wygenerowany zbiór ucz¹cy

    %wczytanie macierzy z danych wejœciowych
    in_mtx = csvread(datafilename, 0, 1);
    
    %zbiór ucz¹cy
    l_set = ones(s_cnt*c_cnt, a_cnt);
    
    %zbiór wartoœci wylosowany rozk³adem gaussa (wartoœæ oczekiwana i odchylenie parametryzowane)
    l_set = in_mtx + normrnd(mu, s, s_cnt*c_cnt, a_cnt); 

    
    %-------symbole obce------%
    %liczba symboli obcych
    f_cnt = (30 * s_cnt * c_cnt) / 100;
    
    %wektor symboli obcych
    f_arr = randperm(size(l_set,1), f_cnt);
    
    %macierz cech symboli obcych 
    f_mtx = ones(f_cnt, a_cnt);
    for i = 1 : size(f_arr)
        f_mtx(i, :) = randperm(a_cnt);
    end
    %-------------------------%
    
    
    %zlozenie zbioru ucz¹cego z macierz¹ symboli obcych
    l_set = cat(1, l_set, f_mtx);
    
    
    %-------normalizacja------%
    max_arr = max(l_set);
    max_el = max(max_arr);
    l_set = l_set./max_el;
    %-------------------------%
    
    
    %--podzial na przedzia³y--%    
    section = 1/a_cnt;
    final_set = ones(size(l_set,1), a_cnt, a_cnt);
    
    f_gauss = @(x,x0)  exp(-((x-x0)*(x-x0)));
    
    for i = 1:size(l_set,1)
        for j = 1:a_cnt
            for k = 1:a_cnt
                arg1 = l_set(i,j);
                arg2 = (k-1) * section + section/2;
                final_set(i,j,k) = f_gauss(arg1,arg2);
            end
        end
    end
    
    %-------------------------%
    
    
    %wektor symboli i symboli obcych
    %s_arr = cat(2, in_mtx(:,1), f_arr);
    
    %zbiór ucz¹cy z symbolami i cechami
    %l_set = cat(2, s_arr, l_set);
end

