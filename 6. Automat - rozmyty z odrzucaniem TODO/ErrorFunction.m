function [e_cnt, e_proc] = ErrorFunction(mtx, t_mtx, l_set)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN mtx  - macierz zbioru ucz�cego/testowego
%   IN t_mtx  - macierz przej�cia automatu
%   IN a_cnt - liczba cech symbolu (nie mo�na jej wyci�gn�� z samej mtx)
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�

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