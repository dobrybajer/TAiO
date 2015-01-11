function o_mtx = AutomataRecreator(t_mtx)
%AUTOMATARECREATOR Funkcja konwertuj¹ca dowoln¹ macierz 3D na macierz
%zero-jedynkow¹, gdzie 1 jest tam gdzie maksymalny element w ka¿dej
%kolumnie, a pozosta³e wartoœci w ramach danej kolumny to 0
%IN t_mtx macierz automatu
%OUT o_mtx przekonwertowana macierz
    global etap;
    global ograniczNietermin;
    o_mtx=zeros(size(t_mtx));

    if strcmp(etap,'a3') || strcmp(etap,'a4')
        for i=1:size(t_mtx,3)
            for j=1:size(t_mtx,2)
                sortedValues = sort(t_mtx(:,j,i),'descend');
                if strcmp(etap,'a3')
                    niedeterminizm=floor(ograniczNietermin/100*size(t_mtx,1));
                else
                    niedeterminizm=floor(ograniczNietermin/100*size(t_mtx,1));
                end
                %niedeterminizm
                ones_cnt=randi([0 niedeterminizm],1);
                if(ones_cnt~=0)
                    maxValues = sortedValues(1:ones_cnt);
                    maxValues = maxValues(maxValues>0);
                    maxIndex = ismember(t_mtx(:,j,i),maxValues);
                    o_mtx(maxIndex,j,i)=1; 
                end
            end
        end
    elseif strcmp(etap,'a1') || strcmp(etap,'a2')
        for i=1:size(t_mtx,3)
            [~, maxInd]=max(t_mtx(:,:,i));    
            for j=1:length(maxInd);
               o_mtx(maxInd(j),j,i)=1; 
            end
        end
    end
end

