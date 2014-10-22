function [s_list, c_cnt, mtx] = FileReader(fname, dlm)
%FILEREADER Zaczytanie wartości z pliku tekstowego do programu.
%   IN fname  - nazwa pliku wejściowego
%   IN dlm    - separator użyty podczas czytania z pliku wejściowego
%   OUT s_list - lista unikalnych symboli wejściowych zaczytanych z pliku
%   OUT c_cnt  - liczba reprezentantów klasy danego symbolu
%   OUT mtx    - macierz cech (bez kolumny symboli)

    mtx=dlmread(fname, dlm);
    s_list=unique(mtx(:,1));
    c_cnt=size(mtx,1)/length(s_list);
    %a_mtx=M(:,2:size(M,2));
end

