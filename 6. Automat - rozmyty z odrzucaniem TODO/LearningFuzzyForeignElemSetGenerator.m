function [final_set] = LearningFuzzyForeignElemSetGenerator(s_cnt, c_cnt, a_cnt, d_cnt, mu, s)
%LearningFuzzySetGenerator Tworzenie rozmytego zbioru ucz�cego z elementami
%obcymi
%   IN datafile - plik wej�ciowy
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentant�w klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia?�w
%   IN mu     - warto�� oczekiwana rozk�adu normalnego
%   IN s      - odchylenie standardowe dla rozk�adu normalnego
%   OUT l_set - wygenerowany zbi�r ucz�cy

    %wczytanie macierzy z danych wej�ciowych
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

    %zbi�r ucz�cy
    l_set = ones(s_cnt*c_cnt, a_cnt);
    
    %zbi�r warto�ci wylosowany rozk�adem gaussa (warto�� oczekiwana i odchylenie parametryzowane)
    %l_set = in_mtx(:, 2:end) + normrnd(mu, s, s_cnt*c_cnt, a_cnt); 
    l_set = normrnd(mu, s, s_cnt*c_cnt, a_cnt); 
    %l_set
    %-------symbole obce------%
    %liczba symboli obcych
    f_cnt = ceil((30 * s_cnt * c_cnt) / 100);         %DO SPARAMETRYZOWANIA!!!!!!

    %wektor symboli obcych
    f_arr = randperm(size(l_set,1));
    f_arr = f_arr(1:f_cnt);
    f_arr = f_arr + max(ceil(l_set(:,1)));
    
    
    
    %macierz cech symboli obcych 
    f_mtx = ones(f_cnt, a_cnt);
    for i = 1 : length(f_arr)
        f_mtx(i, :) = randperm(a_cnt);
    end
    %-------------------------%
    
    
    %zlozenie zbioru ucz�cego z macierz� symboli obcych
    l_set = cat(1, l_set, f_mtx);

    
    
    %-------normalizacja------%
    max_arr = max(l_set);
    max_el = max(max_arr);
    l_set = l_set./max_el;
    l_set = abs(l_set);
    %-------------------------%
    
    
    %--podzial na przedzia�y--%
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
    %final_set_dyskretny = ceil(final_set.*d_cnt);
    %-------------------------%
    
    
  
    %z?o?enie z symbolami do pierwszej kolumny 
    symbols_mtx = zeros(size(final_set, 1), 1, size(final_set,3));
    symbols_mtx(:,1,1) = cat(1, symbols_arr, f_arr');
    final_set = cat(2,symbols_mtx, final_set);
    
    for i=2:size(final_set,3)
        final_set(:,1,i) = final_set(:,1,1);
    end
    
    
end

