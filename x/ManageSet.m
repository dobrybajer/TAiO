function l_set = ManageSet(l_set, d_cnt, l_bnd, u_bnd)
%ManageSet Funkcja dostosowywuje zbiór ucz¹cy do potrzeb etapu
%   IN l_set  - zbior cech
%   IN d_cnt  - liczba podzia³ów przedzia³u (0,1) na cyfry 1,2,...,n
%   IN l_bnd  - dolne ograniczenie dla przedzia³u rozkladu jednostajnego
%   IN u_bnd  - górne ograniczenie dla przedzia³u rozk³adu jednostajnego
%   OUT l_set - zmieniony zbiór cech
    l_set=l_set./(u_bnd-l_bnd); % zbiór cech zosta³ znormalizowany do przedzialu [0,1]
    l_set(l_set>=1)=1;
    l_set=ceil(l_set.*d_cnt); % zamiana wartoœci na przedzia³y, w jakich siê dane wartoœci znajduj¹, w zaleznosci od liczby podzialów
end

