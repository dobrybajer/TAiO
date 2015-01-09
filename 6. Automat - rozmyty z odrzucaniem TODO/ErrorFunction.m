function [e_cnt, e_proc] = ErrorFunction(mtx, t_mtx)
%ERRORFUNCTION Funkcja b³êdu symuluj¹ca obliczenie automatu dla danego
%zbioru wejœciowego (ucz¹cego) oraz danej macierzy przejœcia automatu.
%Funkcja zwraca liczbê b³êdów oraz u³amek udanych rozpoznañ.
%   IN mtx  - macierz zbioru ucz¹cego/testowego
%   IN t_mtx  - macierz przejœcia automatu
%   IN a_cnt - liczba cech symbolu (nie mo¿na jej wyci¹gn¹æ z samej mtx)
%   OUT e_cnt  - liczba znalezionych b³êdów
%   OUT e_proc - u³amek b³êdnych rozpoznañ
    e_cnt=0;
    
    for i=1:size(mtx,1)
       w_input = mtx(i,2:end,:);
       s_output=AutomataComputation(t_mtx, squeeze(w_input), size(mtx,2)-1);
       
       if mtx(i,1,1) > length(s_output)
           index = length(s_output);
       else
           index = mtx(i,1,1);
       end
       
       if s_output(index) == 1 || index == find(s_output == max(s_output), 1)
           var = 0;
       else
           var = 1 - (s_output(index)/sum(s_output));
       end
       e_cnt= e_cnt + var;
    end
    e_proc=e_cnt/size(mtx,1);
end