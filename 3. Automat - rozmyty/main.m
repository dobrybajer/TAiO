liczba_symboli=5;
liczba_reprezentantow=10;
liczba_cech=5;
liczba_podzialow=5;
l_bnd=0;
u_bnd=20;

tic

zbior_uczacy=LearningSetGenerator(liczba_symboli,liczba_reprezentantow,liczba_cech,liczba_podzialow,l_bnd,u_bnd);

macierz_przejscia=AutomataGenerator(liczba_symboli,liczba_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction('genLearningSet.dat',macierz_przejscia);

disp(['Ilo�� b��d�w dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(ilosc_bledow)]); 
disp(['U�amek b��dnie rozpoznanych symboli dla danego zbioru ucz�cego/treningowego wynosi:'  num2str(procent_bledow)]); 

%macierz3d = PSO(funkcjabledu,ograniczenie)
%[ilosc_bledow,procent_bledow]=ErrorFunction('genLearningSet.dat',macierz3d);

toc