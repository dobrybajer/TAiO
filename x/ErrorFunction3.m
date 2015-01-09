function [e_cnt, e_proc, o_mtx] = ErrorFunction3(mtx, t_mtx, flaga, classToFile, errorToFile)
%ERRORFUNCTION Funkcja b³êdu symuluj¹ca obliczenie automatu dla danego
%zbioru wejœciowego (ucz¹cego) oraz danej macierzy przejœcia automatu.
%Funkcja zwraca liczbê b³êdów oraz u³amek udanych rozpoznañ.
%   IN mtx  - macierz zbioru ucz¹cego/testowego
%   IN t_mtx  - macierz przejœcia automatu
%   OUT e_cnt  - liczba znalezionych b³êdów
%   OUT e_proc - u³amek b³êdnych rozpoznañ
     
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
        o_mtx=AutomataRecreator(t_mtx,flaga); % zmiana macierzy przejœcia na macierz zero-jedynkow¹ (niedeterministyczn¹)
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

