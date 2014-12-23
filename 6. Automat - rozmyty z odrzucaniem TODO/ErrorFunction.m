function [e_cnt, e_proc] = ErrorFunction(mtx, t_mtx, a_cnt)
%ERRORFUNCTION Funkcja b��du symuluj�ca obliczenie automatu dla danego
%zbioru wej�ciowego (ucz�cego) oraz danej macierzy przej�cia automatu.
%Funkcja zwraca liczb� b��d�w oraz u�amek udanych rozpozna�.
%   IN mtx  - macierz zbioru ucz�cego/testowego
%   IN t_mtx  - macierz przej�cia automatu
%   IN a_cnt - liczba cech symbolu (nie mo�na jej wyci�gn�� z samej mtx)
%   OUT e_cnt  - liczba znalezionych b��d�w
%   OUT e_proc - u�amek b��dnych rozpozna�

    e_cnt=0;
    stala = 0.5; % CHWILOWO!!!!!!!
    for i=1:size(mtx,1)
       %w_input=mtx(i,2:size(mtx,2),:)';
       w_input = zeros(a_cnt);
       for j=2:size(mtx,2)
           for k=1:size(mtx,3)
               w_input(j-1) = w_input(j-1) + stala*mtx(i,j,k);  %jak sp�aszcza� macierz w wektor???? 
                                                                %Czy ten wktor musi mie� ca�kowite warto�ci? jak???
           end
       end
       s_output=AutomataComputation(t_mtx,w_input, a_cnt);   
       if  mtx(i,1,1)<=0 || mtx(i,1,1)> length(s_output) || s_output(mtx(i,1,1)) ~= 1 
           e_cnt= e_cnt +1;
           
       end    
    end

    e_proc=e_cnt/size(mtx,1);
end