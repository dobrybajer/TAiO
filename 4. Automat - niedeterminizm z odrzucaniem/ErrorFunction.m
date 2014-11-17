function [e_cnt, e_proc, o_mtx] = ErrorFunction(mtx, t_mtx, flag)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN mtx  - macierz zbioru ucz�cego/testowego
%   IN t_mtx  - macierz przej�cia automatu
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�
    
    %x_mtx=all(t_mtx==0 | t_mtx==1);
    %if(sum(x_mtx(:))~=size(t_mtx,2)*size(t_mtx,3))
    o_mtx=t_mtx;
    if(flag==1)
        o_mtx=AutomataRecreator(t_mtx); % zmiana macierzy przej�cia na macierz zero-jedynkow� (niedeterministyczn�)
    end
    
    e_cnt=0;
    for i=1:size(mtx,1)
       w_input=mtx(i,2:size(mtx,2))';
       s_output=AutomataComputation(o_mtx,w_input);
       if ((ismember(mtx(i,1),s_output)~=1 && ismember(size(t_mtx,1),s_output)~=1) ...
           || (ismember(mtx(i,1),s_output)~=1 && ismember(size(t_mtx,1),s_output)==1 && sum(w_input>size(t_mtx,3))==0))
           e_cnt=e_cnt+1;
       end
    end

    e_proc=e_cnt/size(mtx,1);
end

