liczba_symboli=5;
liczba_reprezentantow=10;
liczba_cech=6;
liczba_podzialow=4;
l_bnd=0;
u_bnd=20;
disp(' ');
tic

zbior_uczacy=LearningSetGenerator(liczba_symboli,liczba_reprezentantow,liczba_cech,liczba_podzialow,l_bnd,u_bnd);

macierz_przejscia=AutomataGenerator(liczba_symboli,liczba_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunction('genLearningSet.dat',macierz_przejscia);



disp(['Iloœæ b³êdów dla danego zbioru ucz¹cego/treningowego wynosi:'  num2str(ilosc_bledow)]); 
disp(['U³amek b³êdnie rozpoznanych symboli dla danego zbioru ucz¹cego/treningowego wynosi:'  num2str(procent_bledow)]); 

toc
disp(' ');
tic

[macierz3d, blad] = PSO(liczba_symboli,liczba_podzialow,zbior_uczacy);

disp(['PSO/U³amek b³êdnie rozpoznanych symboli dla danego zbioru ucz¹cego/treningowego wynosi:'  num2str(blad)]); 
disp(' ');
[ilosc_bledow2,procent_bledow2]=ErrorFunction2(zbior_uczacy,macierz3d);

disp(['PO PSO/Iloœæ b³êdów dla danego zbioru ucz¹cego/treningowego wynosi:'  num2str(ilosc_bledow2)]); 
disp(['PO PSO/U³amek b³êdnie rozpoznanych symboli dla danego zbioru ucz¹cego/treningowego wynosi:'  num2str(procent_bledow2)]);

toc
