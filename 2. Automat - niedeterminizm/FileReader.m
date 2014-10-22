function [s_list, c_cnt, mtx] = FileReader(fname, dlm)
%FILEREADER Zaczytanie wartoœci z pliku tekstowego do programu.
%   IN fname  - nazwa pliku wejœciowego
%   IN dlm    - separator u¿yty podczas czytania z pliku wejœciowego
%   OUT s_list - lista unikalnych symboli wejœciowych zaczytanych z pliku
%   OUT c_cnt  - liczba reprezentantów klasy danego symbolu
%   OUT mtx    - macierz cech (bez kolumny symboli)

    mtx=dlmread(fname, dlm);
    s_list=unique(mtx(:,1));
    c_cnt=size(mtx,1)/length(s_list);
    %a_mtx=M(:,2:size(M,2));
end

