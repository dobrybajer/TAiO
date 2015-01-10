function n = AutomataComputation(t_mtx, w_input, a_cnt)
%AUTOMATACOMPUTATION Symulacja obliczenia automatu, poprzez mno¿enie macierzy (zamiast mno¿enia -> min, zamiast sumowania -> max) 
% IN t_mtx   - macierz przejœcia danego automatu
% IN w_input - s³owo wejœciowe reprezentowane przez symbole z podzia³u cech
% IN a_cnt - liczba cech danego symbolu
% IN flaga - parametr oznaczaj¹cy typ automatu
% OUT n       - numer wykrytego symbolu
    global etap;

    n=0;

    col_len=size(t_mtx,1);
    word_len=length(w_input);
    
    w_output=zeros(col_len,1);
    w_start=w_output;
    w_new=w_output;
   
    w_start(1)=1; % sta³y stan pocz¹tkowy
    if (strcmp(etap,'a1') || strcmp(etap,'a3'))
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
    elseif (strcmp(etap,'a2') || strcmp(etap,'a4'))
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
    elseif (strcmp(etap,'a5') || strcmp(etap,'a6'))
        w_start=rand(col_len,1);
        %w_start=zeros(col_len,1);
     
        for i=1:a_cnt
            var = zeros(col_len,a_cnt);
            for r=1:size(w_input,1)
                for k=1:col_len
                    
                    for l=1:col_len 
                       w_new(l)=1 -tanh(atanh(1-t_mtx(k,l,r)) + atanh(1-w_start(l)));
                    end    
                   
                    z = length(w_new);
                    %In first element in w_new, there is a maximum of vector%
                    while z > 1
                        w_new(z-1) = tanh(atanh(w_new(z-1)) + atanh(w_new(z)));
                        z = z-1;
                    end
                  
              
                    %disp(['i ' num2str(i) ' r ' num2str(r) ' k ' num2str(k)]);
                    w_output(k)=w_new(1);
                end
                for p=1:size(w_output,1) 
                   x(p)=1 - tanh(atanh(1-w_output(p)) + atanh(1-w_input(i,r)));
                end  
              
                var(:,r) = x';  
            end
          
            for c1=1:col_len 
                z = a_cnt;
                c2=var(c1,:);
                
                while z > 1
                    c2(z-1) = tanh(atanh(var(c1,z-1)) + atanh(var(c1,z)));
                    z = z-1;
                end
              
                c3(c1)=c2(1);
              
            end
      
           error('xD');
            w_start = c3
            
        end
        n=w_start % zwracamy CA£Y wektor
        error('xD');
    end
end
