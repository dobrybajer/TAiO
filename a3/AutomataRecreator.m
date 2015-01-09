function o_mtx = AutomataRecreator(mtx)
%AUTOMATARECREATOR Funkcja konwertuj¹ca dowoln¹ macierz 3D na macierz
%zero-jedynkow¹, gdzie z macierzy wejœciowej, w ka¿dej kolumnie wybierana
%jest liczba (od 0 do 3) maksymalnych wartoœci - na tych miejsach s¹
%jedynki w kolumnie macierzy wyjœciowej, pozosta³e miejsca wype³nione s¹
%zerami

    o_mtx=zeros(size(mtx));
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
end

