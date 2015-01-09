function [excel_set, l_symboli_x, l_cech_x, l_rep_x] = ReadingExcelFile(path, d_cnt)
%ReadingExcelFile Czyta i zarzadza zawartoscia pliku excel
%   IN l_set  - zbior uczacy (bez pierwszej kolumny)
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentantów klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
%   IN mu     - wartoœæ oczekiwana rozk³adu normalnego
%   IN s      - odchylenie standardowe dla rozk³adu normalnego
%   OUT l_set - zmieniony zbiór ucz¹cy
    [excel_matrix, excel_string] = xlsread(path);
    l_symboli_x = length(unique(excel_matrix));
    l_cech_x = size(excel_string,2) -1;
    l_rep_x = length(excel_matrix)./l_symboli_x;

    l_set = cellfun(@str2double, excel_string(:,2:end));

    [max_val, ~] = max(l_set(:));

    l_set = ManageSet(l_set,d_cnt, 0, max_val);
    excel_set = cat(2,excel_matrix,l_set); % dodanie kolumny symboli
end

