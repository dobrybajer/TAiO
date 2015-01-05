function o_mtx = AutomataRecreator(mtx)
%AUTOMATARECREATOR Funkcja konwertuj¹ca dowoln¹ macierz 3D na macierz
%zero-jedynkow¹, gdzie 1 jest tam gdzie maksymalny element w ka¿dej
%kolumnie, a pozosta³e wartoœci w ramach danej kolumny to 0

    o_mtx=zeros(size(mtx));
    for i=1:size(mtx,3)
        [~, maxInd]=max(mtx(:,:,i));    
        for j=1:length(maxInd);
           o_mtx(maxInd(j),j,i)=1; 
        end
    end
end

