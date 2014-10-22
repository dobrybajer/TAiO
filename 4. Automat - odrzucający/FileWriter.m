function FileWriter(fname, mtx, dlm)
%FILEWRITER Zaczytanie wartoœci z macierzy do pliku tekstowego.
%   IN fname - nazwa pliku
%   IN mtx   - macierz z wartoœciami do zapisania
%   IN dlm   - separator

    dlmwrite(fname, mtx, dlm);
end

