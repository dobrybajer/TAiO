function FileWriter(fname, mtx, dlm)
%FILEWRITER Zaczytanie warto�ci z macierzy do pliku tekstowego.
%   IN fname - nazwa pliku
%   IN mtx   - macierz z warto�ciami do zapisania
%   IN dlm   - separator

    dlmwrite(fname, mtx, dlm);
end

