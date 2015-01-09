function [e_cnt, e_proc, o_mtx] = ErrorFunction3(mtx, t_mtx, flaga, classToFile, errorToFile)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN mtx  - macierz zbioru ucz�cego/testowego
%   IN t_mtx  - macierz przej�cia automatu
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�
     
    flag = 0;
    if nargin == 5 &&  ~isempty(classToFile) && ~isempty(errorToFile)
        flag = 1;
    elseif nargin == 5 &&  ~isempty(classToFile) && isempty(errorToFile)
        flag = 2;
    elseif nargin == 5 &&  isempty(classToFile) && ~isempty(errorToFile)
        flag = 3;
    end
    
    a = zeros(size(mtx,1)); 
    
    o_mtx=t_mtx;
    if(flaga==3)
        o_mtx=AutomataRecreator(t_mtx,flaga); % zmiana macierzy przej�cia na macierz zero-jedynkow� (niedeterministyczn�)
    end
    
    e_cnt=0;
    for i=1:size(mtx,1)
       s_output=AutomataComputation(o_mtx, mtx(i,2:size(mtx,2))', size(mtx,2)-1, 3);
       if ismember(mtx(i,1),s_output)~=1
           e_cnt=e_cnt+1;
       end
    end

    e_proc=e_cnt/size(mtx,1);
    
    c = a(a>0);
    
    if  flag == 1 
        xlswrite(classToFile,c);
        xlswrite(errorToFile,e_proc);
    elseif flag == 3
        xlswrite(classToFile,c);
    elseif flag == 2
        xlswrite(errorToFile,e_proc);
    end
end

