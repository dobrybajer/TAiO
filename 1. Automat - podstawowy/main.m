liczba_symboli=3;
liczba_reprezentantow=15;
liczba_cech=5;
liczba_podzialow=4;
l_bnd=0;
u_bnd=1;

max_iter=100;
liczba_czastek=15;
wspolczynnik_szybkosci_czastek=0.729;
ogr_gorne_czastek=2;
c1=1.49445;
c2=1.49445;

disp(' ');
tic

zbior_uczacy=LearningSetGenerator(liczba_symboli,liczba_reprezentantow,liczba_cech,liczba_podzialow,l_bnd,u_bnd);

macierz_przejscia=AutomataGenerator(liczba_symboli,liczba_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction('genLearningSet.dat',macierz_przejscia);

disp(['Ilo�� b��d�w dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(ilosc_bledow)]); 
disp(['U�amek b��dnie rozpoznanych symboli dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(procent_bledow)]); 

toc
disp(' ');
tic

[macierz3d, blad] = PSO(liczba_symboli,liczba_podzialow,zbior_uczacy,max_iter,liczba_czastek,wspolczynnik_szybkosci_czastek,ogr_gorne_czastek,c1,c2);
disp(['PSO/U�amek b��dnie rozpoznanych symboli dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(blad)]); 
disp(' ');
[ilosc_bledow2,procent_bledow2]=ErrorFunction2(zbior_uczacy,macierz3d);

disp(['PO PSO/Ilo�� b��d�w dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(ilosc_bledow2)]); 
disp(['PO PSO/U�amek b��dnie rozpoznanych symboli dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(procent_bledow2)]);

toc
