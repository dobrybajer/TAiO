function n = AutomataComputation(t_mtx, w_input, a_cnt)
%AUTOMATACOMPUTATION Symulacja obliczenia automatu, poprzez mno¿enie macierzy (zamiast mno¿enia -> min, zamiast sumowania -> max) 
% IN t_mtx   - macierz przejœcia danego automatu
% IN w_input - s³owo wejœciowe reprezentowane przez symbole z podzia³u cech
% IN a_cnt - liczba cech danego symbolu
% OUT n       - numer wykrytego symbolu
     col_len=size(t_mtx,1);
    
    w_output=zeros(col_len,1);
    w_start=w_output;
    w_new=w_output;
    
    w_start(1)=1; % sta³y stan pocz¹tkowy
    for i=1:a_cnt
        var = zeros(col_len,1);
        for r=1:size(w_input,2)
            for k=1:col_len
                for l=1:col_len
                   w_new(l)=1 -tanh(atanh(1-t_mtx(k,l,r) + atanh(1-w_start(l))));
                end       
                z = length(w_new);
                %In first element in w_new, there is a maximum of vector%
                while z > 1
                    w_new(z-1) = tanh(atan(w_new(z-1)) + atanh(w_new(z)));
                    z = z-1;
                end
                w_output(k)=w_new(1);
            end
            var = var + w_output.*w_input(i,r);    
        end
        w_start = var;
    end

    n=w_start; % zwracamy CA£Y wektor
end
