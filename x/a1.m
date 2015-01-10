if(~exist('isRunByTAIO','var') || ~isRunByTAIO)
    error('This is not run by TAIO2014');
end

%__________PARAMETRY OGÓLNE___________%
l_symboli=iloscKlas;    % unikalne wartoœci z 1-szej kolumny
l_rep=iloscPowtorzenWKlasie;       % liczba powtórzeñ powy¿szych
l_cech=iloscCech;       % d³ugoœæ s³owa opisuj¹cego dany symbol
l_podzialow=dyskretyzacja;  % liczba stanów w automacie

l_bnd= minLos;      % dolny zakres wartoœci zbioru ucz¹cego
u_bnd= maxLos;        % górny zakres wartoœci zbioru ucz¹cego
war_oczek=0;    % wartoœæ oczekiwana dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
odch_std=1;   % odchylenie standardowe dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
log=1;          % 1 - info w logu, 0 - brak info w logu
%_____________________________________%

%__________PARAMETRY DLA PSO__________%
max_iter=PSOiter;
l_czastek=PSOs;
v_czastek=0.729; % interia weight
u_bnd_czastek=PSOd; % ograniczenie górne search space cz¹stki
c1=PSOcp; %cp
c2=PSOcg; %cg
%_____________________________________%

startGeneration=tic;

if (strcmp(wejscieTyp,'gen'))
    zbior_uczacy=LearningSetGenerator1(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std);
    zbior_treningowy = TrainingSetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std);
else 
    [zbior_treningowy, ~, ~, ~] = ReadingExcelFile(sciezkaTest,l_podzialow);
    [zbior_uczacy, l_symboli, l_cech, l_rep] = ReadingExcelFile(sciezkaTrain,l_podzialow);    
end    

macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction(zbior_uczacy,macierz_przejscia);
PrintInfo(0,[procent_bledow ilosc_bledow l_symboli*l_rep max_iter*l_czastek toc(startGeneration)]);

startPso=tic;

[macierz3d, blad] = PSO(l_symboli,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log,@ErrorFunction);
PrintInfo(1,blad);

disp('');
disp('Dla zbioru treningowego:');
disp('');

macierz3d=AutomataRecreator(macierz3d);

[ilosc_bledow2,procent_bledow2]=ErrorFunction(zbior_treningowy,macierz3d,sciezkaOutputKlas,sciezkaOutputErr);
PrintInfo(2,[procent_bledow2 ilosc_bledow2 l_symboli*l_rep toc(startPso)]);