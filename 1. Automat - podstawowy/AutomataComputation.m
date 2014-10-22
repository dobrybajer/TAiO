function n = AutomataComputation(t_mtx, w_input)
%AUTOMATACOMPUTATION Symulacja obliczenia automatu, poprzez mno¿enie macierzy (zamiast mno¿enia -> min, zamiast sumowania -> max) 
% IN t_mtx   - macierz przejœcia danego automatu
% IN w_input - s³owo wejœciowe reprezentowane przez symbole z podzia³u cech
% OUT n       - numer wykrytego symbolu
    col_len=size(t_mtx,1);
    word_len=length(w_input);
    
    w_output=zeros(col_len,1);
    w_start=w_output;
    w_new=w_output;
    
    r=randi(col_len);
    w_start(r)=1;

    for i=1:word_len
        n=w_input(i);
        for k=1:col_len
            for l=1:col_len
               w_new(l)=min(t_mtx(k,l,n),w_start(l));
            end
            w_output(k)=max(w_new);
        end
        w_start=w_output;
    end
    n=find(w_start);
end
