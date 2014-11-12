function out_vec = fmain(u_bnd, maxIter,pCount,wspol, u_bnd2,c1,c2  )
%FMAIN Summary of this function goes here
%   Detailed explanation goes here
liczba_symboli=3;
liczba_reprezentantow=15;
liczba_cech=5;
liczba_podzialow=4;
l_bnd=0;

tic 

zbior_uczacy=LearningSetGenerator(liczba_symboli,liczba_reprezentantow,liczba_cech,liczba_podzialow,l_bnd,u_bnd);

macierz_przejscia=AutomataGenerator(liczba_symboli,liczba_podzialow);

[~,procent_bledow]=ErrorFunction2(zbior_uczacy, macierz_przejscia);

[macierz3d, blad] = PSO(liczba_symboli,liczba_podzialow,zbior_uczacy,maxIter,pCount,wspol, u_bnd2,c1,c2);

[~,procent_bledow2]=ErrorFunction2(zbior_uczacy,macierz3d);

v=toc;

out_vec=[u_bnd maxIter pCount wspol u_bnd2 c1 c2 procent_bledow blad procent_bledow2 v];

end

