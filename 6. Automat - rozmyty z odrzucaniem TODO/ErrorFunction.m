function [e_cnt, e_proc] = ErrorFunction(mtx, t_mtx, l_set)
%ERRORFUNCTION Funkcja b³êdu symuluj¹ca obliczenie automatu dla danego
%zbioru wejœciowego (ucz¹cego) oraz danej macierzy przejœcia automatu.
%Funkcja zwraca liczbê b³êdów oraz u³amek udanych rozpoznañ.
%   IN mtx  - macierz zbioru ucz¹cego/testowego
%   IN t_mtx  - macierz przejœcia automatu
%   IN a_cnt - liczba cech symbolu (nie mo¿na jej wyci¹gn¹æ z samej mtx)
%   OUT e_cnt  - liczba znalezionych b³êdów
%   OUT e_proc - u³amek b³êdnych rozpoznañ

    e_cnt=0;
    
    for i=1:size(l_set,1)
       w_wynikowy = zeros(size(l_set,2));
       w_input=l_set(i,:);
       s_output=AutomataComputation(t_mtx,w_input, size(l_set,2));
       for j=1:size(l_set,2)
           for k=1:size(mtx,3)
                w_wynikowy(j) = mtx(i,j+1,k)*s_output(j) + w_wynikowy(j);
           end
       end
       if  mtx(i,1,1)<=0 || mtx(i,1,1)> length(w_wynikowy) || w_wynikowy(mtx(i,1,1)) ~= 1 
           e_cnt= e_cnt +1;
       end    
    end

    e_proc=e_cnt/size(mtx,1);
end