function [e_cnt, e_proc, o_mtx] = ErrorFunction(mtx, t_mtx, classToFile, errorToFile)
%ERRORFUNCTION Funkcja b³êdu symuluj¹ca obliczenie automatu dla danego
%zbioru wejœciowego (ucz¹cego) oraz danej macierzy przejœcia automatu.
%Funkcja zwraca liczbê b³êdów oraz u³amek udanych rozpoznañ.
%   IN mtx  - macierz zbioru ucz¹cego/testowego
%   IN t_mtx  - macierz przejœcia automatu
%   OUT e_cnt  - liczba znalezionych b³êdów
%   OUT e_proc - u³amek b³êdnych rozpoznañ
    global etap;
    o_mtx=t_mtx;

    global real_class_label;
    
    if exist('real_class_label','var') && ~isempty(real_class_label)
        vector_flag = 1;
    else
        vector_flag = 0;
    end
   
    flag = 0;
    if nargin == 4 &&  ~isempty(classToFile) && ~isempty(errorToFile)
        flag = 1;
    elseif nargin == 4 &&  ~isempty(classToFile) && isempty(errorToFile)
        flag = 2;
    elseif nargin == 4 &&  isempty(classToFile) && ~isempty(errorToFile)
        flag = 3;
    end
    
    e_cnt=0;
    %zakaladmy ze 0,14 nigdy nie bedzie ani klasa ani elementem obcym%
    a = zeros(size(mtx,1),1)+0.14;  
    if strcmp(etap,'a1')
        if nargin == 3
            t_mtx=AutomataRecreator(t_mtx); % zmiana macierzy przejœcia na macierz zero-jedynkow¹ (tylko w PSO)   
        end
        
        for i=1:size(mtx,1)
           s_output=AutomataComputation(t_mtx, mtx(i,2:end)');
           if s_output~=mtx(i,1)
               e_cnt=e_cnt+1;
           elseif vector_flag == 1
               a(i)= real_class_label(mtx(i,1));
           else
               a(i)= mtx(i,1);
           end
        end
    elseif strcmp(etap,'a2')
        if nargin == 3
            t_mtx=AutomataRecreator(t_mtx); % zmiana macierzy przejœcia na macierz zero-jedynkow¹ (tylko w PSO)
        end

        for i=1:size(mtx,1)
           s_output=AutomataComputation(t_mtx,mtx(i,2:end)');
           if any(s_output~=mtx(i,1)) || (s_output==size(t_mtx,1) && mtx(i,1)>0)
               e_cnt=e_cnt+1;
           elseif vector_flag == 1
               a(i)= real_class_label(mtx(i,1));
           else
               a(i)= mtx(i,1);
           end
        end
    elseif strcmp(etap,'a3')
        if nargin == 3
            o_mtx=AutomataRecreator(t_mtx); % zmiana macierzy przejœcia na macierz zero-jedynkow¹ (niedeterministyczn¹)
        end
        
        for i=1:size(mtx,1)
           s_output=AutomataComputation(o_mtx, mtx(i,2:end)');
           if ismember(mtx(i,1),s_output)~=1
               e_cnt=e_cnt+1;
           elseif vector_flag == 1
               a(i)= real_class_label(mtx(i,1));
           else
               a(i)= mtx(i,1);
           end
        end     
    elseif strcmp(etap,'a4')
        if nargin == 3
            o_mtx=AutomataRecreator(t_mtx); % zmiana macierzy przejœcia na macierz zero-jedynkow¹ (niedeterministyczn¹)
        end
        
        for i=1:size(mtx,1)
           s_output=AutomataComputation(o_mtx,mtx(i,2:end)');
           if (ismember(mtx(i,1),s_output)~=1 && mtx(i,1)>0) || (ismember(mtx(i,1),s_output)~=1 && ismember(size(t_mtx,1),s_output)~=1 && mtx(i,1)>=size(t_mtx,1))
               e_cnt=e_cnt+1;
           elseif vector_flag == 1
               a(i)= real_class_label(mtx(i,1));
           else
               a(i)= mtx(i,1);
           end
        end
    elseif strcmp(etap,'a5')
        for i=1:size(mtx,1)
           s_output=AutomataComputation(t_mtx, squeeze(mtx(i,2:end,:))', size(mtx,2)-1);

           index = mtx(i,1,1);
            
           if s_output(index) == 1 || index == find(s_output == max(s_output), 1)
               var = 0;
               
               if vector_flag == 1
                    a(i)= real_class_label(mtx(i,1));
               else
                    a(i)= mtx(i,1);
               end
               
           else
               var = 1 - (s_output(index)/sum(s_output));
           end
           e_cnt= e_cnt + var;
        end
    elseif strcmp(etap,'a6')
        for i=1:size(mtx,1)
           s_output=AutomataComputation(t_mtx, squeeze(mtx(i,2:end,:))', size(mtx,2)-1);

           if mtx(i,1,1) > length(s_output)
               index = length(s_output);
           else
               index = mtx(i,1,1);
           end

           if s_output(index) == 1 || index == find(s_output == max(s_output), 1)
               var = 0;
               if vector_flag == 1
                    a(i)= real_class_label(mtx(i,1));
               else
                    a(i)= mtx(i,1);
               end
           else
               var = 1 - (s_output(index)/sum(s_output));
           end
           e_cnt= e_cnt + var;
        end
    end
   
    e_proc=e_cnt/size(mtx,1);
    
    c = a(a~=0.14);

    if  flag == 1 && ~isempty(c)
        if exist(classToFile, 'file')==2
            delete(classToFile);
        end
        xlswrite(classToFile,c);
        xlswrite(errorToFile,e_proc);
    elseif flag == 2 && ~isempty(c)
        if exist(classToFile, 'file')==2
            delete(classToFile);
        end
        xlswrite(classToFile,c);
    elseif flag == 3
        xlswrite(errorToFile,e_proc);
    end
end

