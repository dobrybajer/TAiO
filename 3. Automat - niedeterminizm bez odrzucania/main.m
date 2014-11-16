%__________PARAMETRY OGÓLNE___________%
l_symboli=10;   % unikalne wartoœci z 1-szej kolumny
l_rep=10;       % liczba powtórzeñ powy¿szych
l_cech=10;       % d³ugoœæ s³owa opisuj¹cego dany symbol
l_podzialow=4;  % liczba stanów w automacie
l_bnd=0;        % dolny zakres wartoœci zbioru ucz¹cego
u_bnd=10;       % górny zakres wartoœci zbioru ucz¹cego
war_oczek=0;    % wartoœæ oczekiwana dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
odch_std=2;     % odchylenie standardowe dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
%_____________________________________%


%__________PARAMETRY DLA PSO__________%
max_iter=100;
l_czastek=15;
v_czastek=0.729;
u_bnd_czastek=1;
c1=sqrt(2);
c2=sqrt(2);
%_____________________________________%

disp(' ');
tic

zbior_uczacy=LearningSetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std);

macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunctionFile('genLearningSet.dat',macierz_przejscia);

disp(['B³¹d na starcie: ' num2str(procent_bledow*100,2) '% (' num2str(ilosc_bledow) ' z ' num2str(l_symboli*l_rep) ')']); 

toc
disp(' ');
tic

[macierz3d, blad] = PSO(l_symboli,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2);

disp(['B³¹d wyznaczony przez PSO: ' num2str(blad*100,2) '%']); 
disp(' ');

[ilosc_bledow2,procent_bledow2,~]=ErrorFunction(zbior_uczacy,macierz3d,0);

disp(['B³¹d na nowym automacie wyznaczonym przez PSO: ' num2str(procent_bledow2*100,2) '% (' num2str(ilosc_bledow2) ' z ' num2str(l_symboli*l_rep) ')']);

toc
