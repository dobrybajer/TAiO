if(~exist('isRunByTAIO','var') || ~isRunByTAIO)
    error('This is not run by TAIO2014');
end
<<<<<<< HEAD

%__________PARAMETRY OGÓLNE___________%
l_symboli=iloscKlas;    % unikalne wartoœci z 1-szej kolumny
l_rep=iloscPowtorzenWKlasie;       % liczba powtórzeñ powy¿szych
l_cech=iloscCech;       % d³ugoœæ s³owa opisuj¹cego dany symbol
l_podzialow=dyskretyzacja;  % liczba stanów w automacie

l_bnd= minLos;      % dolny zakres wartoœci zbioru ucz¹cego
u_bnd= maxLos;        % górny zakres wartoœci zbioru ucz¹cego
=======
%__________PARAMETRY OGÓLNE___________%
l_symboli=iloscKlas;   % unikalne wartoœci z 1-szej kolumny
l_rep=iloscPowtorzenWKlasie;       % liczba powtórzeñ powy¿szych
l_cech=iloscCech;       % d³ugoœæ s³owa opisuj¹cego dany symbol
l_podzialow=dyskretyzacja;  % liczba stanów w automacie
l_bnd=minLos;        % dolny zakres wartoœci zbioru ucz¹cego
u_bnd=maxLos;       % górny zakres wartoœci zbioru ucz¹cego
>>>>>>> origin/newview
war_oczek=0;    % wartoœæ oczekiwana dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
odch_std=1;   % odchylenie standardowe dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
log=1;          % 1 - info w logu, 0 - brak info w logu
%_____________________________________%

%__________PARAMETRY DLA PSO__________%
max_iter=PSOiter;
l_czastek=PSOs;
v_czastek=0.729; % interia weight
u_bnd_czastek=PSOd; % ograniczenie górne search space cz¹stki
<<<<<<< HEAD
c1=PSOcp; %cp
c2=PSOcg; %cg
%_____________________________________%

startGeneration=tic;

if (strcmp(wejscieTyp,'gen'))
    zbior_uczacy=LearningSetGenerator5(l_symboli,l_rep,l_cech,l_podzialow,war_oczek,odch_std);
    zbior_treningowy = TrainingSetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std); % LE 
else 
    [zbior_treningowy, ~, ~, ~] = ReadingExcelFile(sciezkaTest,l_podzialow);
    [zbior_uczacy, l_symboli, l_cech, l_rep] = ReadingExcelFile(sciezkaTrain,l_podzialow);    
end  

macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction(zbior_uczacy,macierz_przejscia);
=======
c1=PSOcp;
c2=PSOcg;
%_____________________________________%

startGeneration=tic;
if(strcmp(wejscieTyp,'gen'))
    zbior_uczacy=LearningSetGenerator5(l_symboli,l_rep,l_cech,l_podzialow,war_oczek,odch_std);
    macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow,5);
else
    [zbior_uczacy, l_symboli, l_cech, l_rep] = ReadingExcelFile(sciezkaTrain,l_podzialow);
    [zbior_treningowy, ~, ~, ~] = ReadingExcelFile(sciezkaTest,l_podzialow);
    [compute_bounds] = zbior_treningowy(2:end,:);
    zbior_uczacy=LearningSetGenerator5(l_symboli,l_rep,l_cech,l_podzialow,0,ceil(max(max(compute_bounds))),war_oczek,odch_std);
end

[ilosc_bledow,procent_bledow]=ErrorFunction5(zbior_uczacy,macierz_przejscia,5);
>>>>>>> origin/newview
PrintInfo(0,[procent_bledow ilosc_bledow size(zbior_uczacy,1) max_iter*l_czastek toc(startGeneration)]);

startPso=tic;

<<<<<<< HEAD
[macierz3d, blad] = PSO(l_symboli,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log,@ErrorFunction);
=======
[macierz3d, blad] = PSO(l_symboli,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log,@ErrorFunction5,5);
>>>>>>> origin/newview
PrintInfo(1,blad);

disp('');
disp('Dla zbioru treningowego:');
disp('');

<<<<<<< HEAD
[ilosc_bledow2,procent_bledow2]=ErrorFunction(zbior_uczacy,macierz3d,sciezkaOutputKlas,sciezkaOutputErr);
=======
macierz3d=AutomataRecreator(macierz3d,1);

[ilosc_bledow2,procent_bledow2]=ErrorFunction5(zbior_uczacy,macierz3d,5);
>>>>>>> origin/newview
PrintInfo(2,[procent_bledow2 ilosc_bledow2 l_symboli*l_rep toc(startPso)]);