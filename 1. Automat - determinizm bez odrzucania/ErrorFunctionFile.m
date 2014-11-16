function [e_cnt, e_proc] = ErrorFunctionFile(fname, t_mtx)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN fname  - nazwa pliku wej�ciowego
%   IN t_mtx  - macierz przej�cia automatu
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�

    [~, ~, mtx]=FileReader(fname, ';'); % doda� niezale�no�� od dlm
    e_cnt=0;
    for i=1:size(mtx,1)
       s_output=AutomataComputation(t_mtx, mtx(i,2:size(mtx,2))');
       if s_output~=mtx(i,1)
           e_cnt=e_cnt+1;
       end
    end
    e_proc=e_cnt/size(mtx,1);
end

