function [e_cnt, e_proc, o_mtx] = ErrorFunction(mtx, t_mtx, flag)
%ERRORFUNCTION Funkcja b³êdu symuluj¹ca obliczenie automatu dla danego
%zbioru wejœciowego (ucz¹cego) oraz danej macierzy przejœcia automatu.
%Funkcja zwraca liczbê b³êdów oraz u³amek udanych rozpoznañ.
%   IN mtx  - macierz zbioru ucz¹cego/testowego
%   IN t_mtx  - macierz przejœcia automatu
%   OUT e_cnt  - liczba znalezionych b³êdów
%   OUT e_proc - u³amek b³êdnych rozpoznañ
    
    o_mtx=t_mtx;
    if(flag==1)
        o_mtx=AutomataRecreator(t_mtx); % zmiana macierzy przejœcia na macierz zero-jedynkow¹ (niedeterministyczn¹)
    end
    
    e_cnt=0;
    for i=1:size(mtx,1)
       s_output=AutomataComputation(o_mtx, mtx(i,2:size(mtx,2))');
       if ismember(mtx(i,1),s_output)~=1
           e_cnt=e_cnt+1;
       end
    end

    e_proc=e_cnt/size(mtx,1);
end

