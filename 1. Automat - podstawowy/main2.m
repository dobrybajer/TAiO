A=zeros(11,200);
maxIter=100;
maxIterChg=10;
for i=1:200
    u_bnd=randi([1 20]);
    maxIter=maxIter+maxIterChg;
    if(mod(i,90)==0)
        maxIter=-maxIter;
    end
    pCount=randi([4 32]);
    wspol=rand();
    u_bnd2=randi([1 10]);
    c1=0 + (2-0)*rand();
    c2=0 + (2-0)*rand();
    A(:,i)=fmain(u_bnd, maxIter,pCount,wspol, u_bnd2,c1,c2);
    disp(['Operacja: ', num2str(i)]);
end
A=A';
dlmwrite('gen2.csv', A, ';');