if(~exist('isRunByTAIO','var') || ~isRunByTAIO)
    error('This is not run by TAIO2014');
end

%__________PARAMETRY OG�LNE___________%
l_symboli=iloscKlas;    % unikalne warto�ci z 1-szej kolumny
l_rep=iloscPowtorzenWKlasie;       % liczba powt�rze� powy�szych
l_cech=iloscCech;       % d�ugo�� s�owa opisuj�cego dany symbol
l_podzialow=dyskretyzacja;  % liczba stan�w w automacie

w_smax=0.25; 
l_bnd= minLos;      % dolny zakres warto�ci zbioru ucz�cego
u_bnd= maxLos;        % g�rny zakres warto�ci zbioru ucz�cego
war_oczek=0;    % warto�� oczekiwana dla rozk�adu normalnego (zaburzenie zbioru ucz�cego)
odch_std=1;   % odchylenie standardowe dla rozk�adu normalnego (zaburzenie zbioru ucz�cego)
log=1;          % 1 - info w logu, 0 - brak info w logu
%_____________________________________%


startGeneration=tic;

zbior_uczacy=LearningFuzzyForeignElemSetGenerator(w_smax,l_symboli,l_rep,l_cech,l_podzialow,war_oczek,odch_std);

macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction(zbior_uczacy,macierz_przejscia);
PrintInfo(0,[procent_bledow ilosc_bledow size(zbior_uczacy,1) max_iter*l_czastek toc(startGeneration)]);

startPso=tic;

[macierz3d, blad] = PSO(l_symboli+1,l_podzialow, zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log);
PrintInfo(1,blad);

[ilosc_bledow2,procent_bledow2]=ErrorFunction(zbior_uczacy, macierz3d);
PrintInfo(2,[procent_bledow2 ilosc_bledow2 l_symboli*l_rep toc(startPso)]);