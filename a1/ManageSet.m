function l_set = ManageSet(l_set, d_cnt, l_bnd, u_bnd)
%ManageSet Funkcja dostosowywuje zbi�r ucz�cy do potrzeb etapu
%   IN l_set  - zbior cech
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentant�w klasy danego symbolu
%   IN a_cnt  - liczba cech
%   IN d_cnt  - liczba podzia��w przedzia�u (0,1) na cyfry 1,2,...,n
%   IN l_bnd  - dolne ograniczenie dla przedzia�u rozkladu jednostajnego
%   IN u_bnd  - g�rne ograniczenie dla przedzia�u rozk�adu jednostajnego
%   IN mu     - warto�� oczekiwana rozk�adu normalnego
%   IN s      - odchylenie standardowe dla rozk�adu normalnego
%   OUT l_set - zmieniony zbi�r cech
    l_set=l_set./(u_bnd-l_bnd); % zbi�r cech zosta� znormalizowany do przedzialu [0,1]
    l_set(l_set>=1)=1;
    l_set=ceil(l_set.*d_cnt); % zamiana warto�ci na przedzia�y, w jakich si� dane warto�ci znajduj�, w zaleznosci od liczby podzial�w
end

