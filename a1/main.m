if(~exist('isRunByTAIO','var') || ~isRunByTAIO)
    error('This is not run by TAIO2014');
end

%__________PARAMETRY OGÓLNE___________%
l_symboli=10;    % unikalne wartoœci z 1-szej kolumny
l_rep=20;       % liczba powtórzeñ powy¿szych
l_cech=5;       % d³ugoœæ s³owa opisuj¹cego dany symbol
l_podzialow=5;  % liczba stanów w automacie
l_bnd=0;        % dolny zakres wartoœci zbioru ucz¹cego
u_bnd=10;        % górny zakres wartoœci zbioru ucz¹cego
war_oczek=0;    % wartoœæ oczekiwana dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
odch_std=1;   % odchylenie standardowe dla rozk³adu normalnego (zaburzenie zbioru ucz¹cego)
log=1;          % 1 - info w logu, 0 - brak info w logu
%_____________________________________%


%__________PARAMETRY DLA PSO__________%
max_iter=20;
l_czastek=10;
v_czastek=0.729; % interia weight
u_bnd_czastek=1; % ograniczenie górne search space cz¹stki
c1=1.49445;
c2=1.49445;
%_____________________________________%

startGeneration=tic;

zbior_uczacy=LearningSetGenerator(l_symboli,l_rep,l_cech,l_podzialow,l_bnd,u_bnd,war_oczek,odch_std);
macierz_przejscia=AutomataGenerator(l_symboli,l_podzialow);

[ilosc_bledow,procent_bledow]=ErrorFunctionFile('genLearningSet.dat',macierz_przejscia);
PrintInfo(0,[procent_bledow ilosc_bledow l_symboli*l_rep max_iter*l_czastek toc(startGeneration)]);

startPso=tic;

[macierz3d, blad] = PSO(l_symboli,l_podzialow,zbior_uczacy,max_iter,l_czastek,v_czastek,u_bnd_czastek,c1,c2,log);
PrintInfo(1,blad);

[ilosc_bledow2,procent_bledow2]=ErrorFunction(zbior_uczacy,macierz3d);
PrintInfo(2,[procent_bledow2 ilosc_bledow2 l_symboli*l_rep toc(startPso)]);