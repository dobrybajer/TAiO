if(~exist('isRunByTAIO','var') || ~isRunByTAIO)
    error('This is not run by TAIO2014');
end

%__________PARAMETRY OG”LNE___________%
l_symboli=iloscKlas;    % unikalne wartoúci z 1-szej kolumny
l_rep=iloscPowtorzenWKlasie;       % liczba powtÛrzeÒ powyøszych
l_cech=iloscCech;       % d≥ugoúÊ s≥owa opisujπcego dany symbol
l_podzialow=dyskretyzacja;  % liczba stanÛw w automacie

l_bnd= minLos;      % dolny zakres wartoúci zbioru uczπcego
u_bnd= maxLos;        % gÛrny zakres wartoúci zbioru uczπcego
war_oczek=0;    % wartoúÊ oczekiwana dla rozk≥adu normalnego (zaburzenie zbioru uczπcego)
odch_std=1;   % odchylenie standardowe dla rozk≥adu normalnego (zaburzenie zbioru uczπcego)
log=1;          % 1 - info w logu, 0 - brak info w logu
%_____________________________________%

%__________PARAMETRY DLA PSO__________%
max_iter=PSOiter;
l_czastek=PSOs;
v_czastek=0.729; % interia weight
u_bnd_czastek=PSOd; % ograniczenie gÛrne search space czπstki
c1=PSOcp; %cp
c2=PSOcg; %cg
%_____________________________________%

startGeneration=tic;

if (strcmp(wejscieTyp,'gen'))
    zbior_uczacy=LearningSetGenerator5(l_symboli,l_rep,l_cech,l_podzialow,war_oczek,odch_std);
    zbior_treningowy = TrainingSetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std); % èLE 
else 
    [zbior_treningowy, ~, ~, ~] = ReadingExcelFile(sciezkaTest,l_podzialow);
    [zbior_uczacy, l_symboli, l_cech, l_rep] = ReadingExcelFile(sciezkaTrain,l_podzialow);    
end  

macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction(zbior_uczacy,macierz_przejscia);
PrintInfo(0,[procent_bledow ilosc_bledow size(zbior_uczacy,1) max_iter*l_czastek toc(startGeneration)]);

startPso=tic;

[macierz3d, blad] = PSO(l_symboli,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log,@ErrorFunction);
PrintInfo(1,blad);

disp('');
disp('Dla zbioru treningowego:');
disp('');

[ilosc_bledow2,procent_bledow2]=ErrorFunction(zbior_uczacy,macierz3d,sciezkaOutputKlas,sciezkaOutputErr);
PrintInfo(2,[procent_bledow2 ilosc_bledow2 l_symboli*l_rep toc(startPso)]);