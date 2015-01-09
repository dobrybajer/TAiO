function n = AutomataComputation(t_mtx, w_input, a_cnt, flaga)
%AUTOMATACOMPUTATION Symulacja obliczenia automatu, poprzez mno�enie macierzy (zamiast mno�enia -> min, zamiast sumowania -> max) 
% IN t_mtx   - macierz przej�cia danego automatu
% IN w_input - s�owo wej�ciowe reprezentowane przez symbole z podzia�u cech
% IN a_cnt - liczba cech danego symbolu
% IN flaga - parametr oznaczaj�cy typ automatu
% OUT n       - numer wykrytego symbolu
    n=0;

    col_len=size(t_mtx,1);
    word_len=length(w_input);
    
    w_output=zeros(col_len,1);
    w_start=w_output;
    w_new=w_output;
   
    w_start(1)=1; % sta�y stan pocz�tkowy
    if (flaga == 1 | flaga == 3)
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
        [~,n]=max(w_start);
    elseif (flaga == 2 | flaga == 4)
        for i=1:word_len
            n=w_input(i);
            d_cnt=size(t_mtx,3)-1;
            n(n>d_cnt)=d_cnt;
            for k=1:col_len
                for l=1:col_len
                   w_new(l)=min(t_mtx(k,l,n),w_start(l));
                end
                w_output(k)=max(w_new);
            end
            w_start=w_output;
        end
        n=find(w_start);
    elseif (flaga == 5 | flaga == 6)
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
        n=w_start; % zwracamy CA�Y wektor
    end
end
