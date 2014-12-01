function n = AutomataComputation(t_mtx, w_input)
%AUTOMATACOMPUTATION Symulacja obliczenia automatu, poprzez mno�enie macierzy (zamiast mno�enia -> min, zamiast sumowania -> max) 
% IN t_mtx   - macierz przej�cia danego automatu
% IN w_input - s�owo wej�ciowe reprezentowane przez symbole z podzia�u cech
% OUT n       - numer wykrytego symbolu
    col_len=size(t_mtx,1);
    word_len=length(w_input);
    
    w_output=zeros(col_len,1);
    w_start=w_output;
    w_new=w_output;
    
    w_start(1)=1; % sta�y stan pocz�tkowy
    
    for i=1:word_len
        n=w_input(i);
        for k=1:col_len
            for l=1:col_len
               w_new(l)=1 -tanh(atanh(1-t_mtx(k,l,n)) + atanh(1-w_start(l)));
            end       
            z = length(w_new);
            %In first element in w_new, there is a maximum of vector%
            while z > 1
                w_new(z-1) = tanh(atan(w_new(z-1)) + atanh(w_new(z)));
                z = z-1;
            end       
            w_output(k)=w_new(1);           
%             for l=1:col_len
%                 w_new(l)=min(t_mtx(k,l,n),w_start(l));
%             end
%             w_output(k)=max(w_new);
        end
        w_start=w_output;
    end
    
    n=w_start; % zwracamy CA�Y wektor
end
