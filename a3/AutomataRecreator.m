function o_mtx = AutomataRecreator(mtx)
%AUTOMATARECREATOR Funkcja konwertuj�ca dowoln� macierz 3D na macierz
%zero-jedynkow�, gdzie z macierzy wej�ciowej, w ka�dej kolumnie wybierana
%jest liczba (od 0 do 3) maksymalnych warto�ci - na tych miejsach s�
%jedynki w kolumnie macierzy wyj�ciowej, pozosta�e miejsca wype�nione s�
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

