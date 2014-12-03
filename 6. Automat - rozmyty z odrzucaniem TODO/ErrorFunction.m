function [e_cnt, e_proc] = ErrorFunction(mtx, t_mtx)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN mtx  - macierz zbioru ucz�cego/testowego
%   IN t_mtx  - macierz przej�cia automatu
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�

    e_cnt=0;
    for i=1:size(mtx,1)
       w_input=mtx(i,2:size(mtx,2))';
       s_output=AutomataComputation(t_mtx,w_input);   
       if  mtx(i,1)<=0 || mtx(i,1)> length(s_output) || s_output(mtx(i,1)) ~= 1 
           e_cnt= e_cnt +1;
           
       end    
    end

    e_proc=e_cnt/size(mtx,1);
end

