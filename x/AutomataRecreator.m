function o_mtx = AutomataRecreator(mtx, flaga)
%AUTOMATARECREATOR Funkcja konwertuj�ca dowoln� macierz 3D na macierz
%zero-jedynkow�, gdzie 1 jest tam gdzie maksymalny element w ka�dej
%kolumnie, a pozosta�e warto�ci w ramach danej kolumny to 0

    o_mtx=zeros(size(mtx));
    
    if (flaga == 3 | flaga == 4)
        for i=1:size(mtx,3)
            for j=1:size(mtx,2)
                sortedValues = sort(mtx(:,j,i),'descend');
                ones_cnt=randi([0 3],1);
                if(ones_cnt~=0)
                    maxValues = sortedValues(1:ones_cnt);
                    maxValues = maxValues(maxValues>0);
                    maxIndex = ismember(mtx(:,j,i),maxValues);
                    o_mtx(maxIndex,j,i)=1; 
                end
            end
        end
    elseif (flaga == 1 | flaga == 2)
        for i=1:size(mtx,3)
            [~, maxInd]=max(mtx(:,:,i));    
            for j=1:length(maxInd);
               o_mtx(maxInd(j),j,i)=1; 
            end
        end
    end
end

