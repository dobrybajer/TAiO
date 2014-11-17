function FileWriter(fname, mtx, dlm)
%FILEWRITER Zaczytanie wartości z macierzy do pliku tekstowego.
%   IN fname - nazwa pliku
%   IN mtx   - macierz z wartościami do zapisania
%   IN dlm   - separator

    dlmwrite(fname, mtx, dlm);
end

