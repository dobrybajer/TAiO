function [e_cnt, e_proc] = ErrorFunction(mtx, t_mtx)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN mtx  - macierz zbioru ucz�cego/testowego
%   IN t_mtx  - macierz przej�cia automatu
%   IN a_cnt - liczba cech symbolu (nie mo�na jej wyci�gn�� z samej mtx)
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�
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