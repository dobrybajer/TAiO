function PrintInfo(type, args)
    if(type==0 || type==2 || type==3)
        x=length(args);
        hours = floor(args(x) / 3600);
        args(x) = args(x) - hours * 3600;
        mins = floor(args(x) / 60);
        secs = args(x) - mins * 60;
    end
    
    switch type
        case 0
            fprintf('\nB³¹d na starcie: %2.0f%% (%d z %d)\nCzas dzia³ania: %02.0f:%02.0f:%05.2f\n', args(1)*100, args(2), args(3), hours, mins, secs);
            x=args(4)*args(5)*1.2;
            hours = floor(x / 3600);
            x = x - hours * 3600;
            mins = floor(x / 60);
            secs = x - mins * 60;
            fprintf('Przewidywany czas obliczeñ: %02.0f:%02.0f:%02.0f (+/- %02.0f:%02.0f:%02.0f)\n', hours, mins, secs, hours*0.2, mins*0.2, secs*0.2);
        case 1
            fprintf('\nB³¹d wyznaczony przez PSO: %2.0f%%\n', args(1)*100);
        case 2
            fprintf('\nB³¹d na nowym automacie wyznaczonym przez PSO: %2.0f%% (%d z %d)\nCzas dzia³ania: %02.0f:%02.0f:%05.2f\n', args(1)*100, args(2), args(3), hours, mins, secs);
        case 3
            fprintf('\nW iteracji: %d, b³¹d wynosi %2.0f%%\nCzas dzia³ania: %02.0f:%02.0f:%05.2f\n', args(1), args(2)*100, hours, mins, secs);
        otherwise
            fprintf('\nPoda³eœ z³y typ: %d wiadomoœci\n', type); 
    end
end
