function t_set = TrainingSetGenerator(s_cnt, c_cnt, l_set, stranger_cnt)
%LEARNINGSETGENERATOR Tworzenie zbioru treningowego na podstawie zbioru
%ucz¹cego metod¹ prostej kroswalidacji (simple cross-validation)
%   IN s_cnt  - liczba symboli
%   IN c_cnt  - liczba reprezentantów klasy danego symbolu
%   IN l_set - wygenerowany zbiór ucz?cy
%   OUT t_set - wygenerowany zbiór ucz?cy
    global etap;
    if strcmp(etap,'a1') || strcmp(etap,'a2') || strcmp(etap,'a3') || strcmp(etap,'a4')
        t_set=[];
        for i=1:s_cnt
           %x=randperm(c_cnt,ceil(c_cnt/3)); % 1/3 zbioru uczacego 
           x = randperm(c_cnt);
           x = x(1:ceil(c_cnt/3));
           x=x+((i-1)*c_cnt);
           y=l_set(x,:);
           t_set=[t_set;y];
        end

        if stranger_cnt > 0
           %x=randperm(stranger_cnt,ceil(stranger_cnt/3)); % 1/3 zbioru uczacego 
           x = randperm(stranger_cnt);
           x = x(1:ceil(stranger_cnt/3));
           x=x+(s_cnt*c_cnt);
           y=l_set(x,:);
           t_set=[t_set;y];
        end
    else
        t_set = [];
        for i=1:s_cnt
           %x=randperm(c_cnt,ceil(c_cnt/3)); % 1/3 zbioru uczacego 
           x = randperm(c_cnt);
           x = x(1:ceil(c_cnt/3));
           x=x+((i-1)*c_cnt);
           y=l_set(x,:,:);
           t_set=cat(1,t_set, y);
        end
		
		if stranger_cnt > 0
           %x=randperm(stranger_cnt,ceil(stranger_cnt/3)); % 1/3 zbioru uczacego 
           x = randperm(stranger_cnt);
           x = x(1:ceil(stranger_cnt/3));
           x=x+(s_cnt*c_cnt);
           y=l_set(x,:,:);
           t_set=cat(1,t_set, y);
        end
    end
end