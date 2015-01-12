function [excel_set, l_symboli_x, l_cech_x, l_rep_x real_class_label] = ReadingExcelFile(path, d_cnt)
%ReadingExcelFile Czyta i zarzadza zawartoscia pliku excel
%   IN path  - sciezka do pliku
%   IN d_cnt  - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
%   OUT excel_set - zmieniony zbiór ucz¹cy
%   OUT l_symboli_x - liczba symboli
%   OUT l_cech_x - liczba cech
%   OUT l_rep_x - liczba reprezentantów
%   OUT real_class_label - prawdziwe labelki (w programie nie mo¿emy sobie pozwoliæ na zero, poniewa¿ matlab numeruje od 1)
    [excel_matrix, excel_string] = xlsread(path);
    
    l_symboli_x = length(unique(excel_string));
    l_cech_x = size(excel_matrix,2) -1;
    l_rep_x = length(excel_string)./l_symboli_x;
    
    u = cellfun(@str2double, excel_string);
    
    real_class_label = unique(u);
    vector = zeros(length(excel_string),1);
    
    for i=1:l_symboli_x
        for j=1:l_rep_x
            vector((i-1)*(l_rep_x)+j) = i;
        end
    end

    l_set = excel_matrix;    
    
    [max_val, ~] = max(l_set(:));

    l_set = ManageSet(l_set,d_cnt, 0, max_val);
    excel_set = cat(2,vector,l_set); %dodanie kolumny symboli
end

