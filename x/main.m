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
odch_std=zaburzenie;   % odchylenie standardowe dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
log=0;          % 1 - info w logu, 0 - brak info w logu
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

if(strcmp(etap, 'a1') || strcmp(etap, 'a3') || strcmp(etap, 'a5'))
	if (strcmp(wejscieTyp,'gen'))
		[zbior_uczacy,zbior_treningowy]=SetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std);
	else 
		[zbior_treningowy, ~, ~, ~] = ReadingExcelFile(sciezkaTest,l_podzialow);
		[zbior_uczacy, l_symboli, l_cech, l_rep] = ReadingExcelFile(sciezkaTrain,l_podzialow);  
	end   
elseif(strcmp(etap, 'a2') || strcmp(etap, 'a4') || strcmp(etap, 'a6'))
	if (strcmp(wejscieTyp,'gen'))
		[zbior_uczacy,zbior_treningowy]=SetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std,procRozmZaburz);
	else 
		[zbior_treningowy, ~, ~, ~] = ReadingExcelFile(sciezkaTest,l_podzialow);
		[zbior_uczacy, l_symboli, l_cech, l_rep] = ReadingExcelFile(sciezkaTrain,l_podzialow);    
	end   
end

macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction(zbior_uczacy,macierz_przejscia);
PrintInfo(0,[procent_bledow ilosc_bledow size(zbior_uczacy,1) max_iter*l_czastek toc(startGeneration)]);

startPso=tic;

if(strcmp(etap, 'a1') || strcmp(etap, 'a3') || strcmp(etap, 'a5'))
	l_symboli_tmp = l_symboli;
elseif(strcmp(etap, 'a2') || strcmp(etap, 'a4') || strcmp(etap, 'a6'))
	l_symboli_tmp = l_symboli + 1;
end

[macierz3d, blad] = PSO(l_symboli_tmp,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log,@ErrorFunction);
PrintInfo(1,blad);

disp('');
disp('Dla zbioru treningowego:');
disp('');

[ilosc_bledow2,procent_bledow2]=ErrorFunction(zbior_treningowy, macierz3d,sciezkaOutputKlas,sciezkaOutputErr);
PrintInfo(2,[procent_bledow2 ilosc_bledow2 size(zbior_treningowy,1) toc(startPso)]);