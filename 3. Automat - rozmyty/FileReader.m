function [s_list, c_cnt, mtx] = FileReader(fname, dlm)
%FILEREADER Zaczytanie warto�ci z pliku tekstowego do programu.
%   IN fname  - nazwa pliku wej�ciowego
%   IN dlm    - separator u�yty podczas czytania z pliku wej�ciowego
%   OUT s_list - lista unikalnych symboli wej�ciowych zaczytanych z pliku
%   OUT c_cnt  - liczba reprezentant�w klasy danego symbolu
%   OUT mtx    - macierz cech (bez kolumny symboli)

    mtx=dlmread(fname, dlm);
    s_list=unique(mtx(:,1));
    c_cnt=size(mtx,1)/length(s_list);
    %a_mtx=M(:,2:size(M,2));
end

