function TAIO2014( varargin )
%TAIO2014 Summary of this function goes here
 
global isRunByTAIO; 
global wejscieTyp;
global sciezkaTrain;
global sciezkaTest;
global sciezkaOutputKlas;
global sciezkaOutputErr;
global iloscKlas;
%global rownolegle
global iloscCech;
global iloscPowtorzenWKlasie;
global minLos;
global maxLos;
global ograniczNietermin;
global procRozmObce;
global zaburzenie;
global procRozmTest;
global dyskretyzacja;
global PSOiter;
global PSOs;
global PSOk;
global PSOp

genForbiddenParams = {'sciezkaTrain';'sciezkaTest';'sciezkaObceTrain';'sciezkaObceTest'};
czytForbiddenParams = {'iloscKlas';'iloscCech';'iloscPowtorzenWKlasie';'minLos';'maxLos';'zaburzenie';'procRozmTest';'procRozmObce'};

options = struct('etap', '', 'wejscieTyp','','sciezkaTrain','','sciezkaTest','', ...
'sciezkaOutputKlas','','sciezkaOutputErr','','iloscKlas', 0,'rownolegle',0, ...
'iloscCech', 0, 'iloscPowtorzenWKlasie', 0, 'minLos', 0, 'maxLos',0,'ograniczNietermin',0, ... 
'procRozmObce','','zaburzenie', 0, 'procRozmTest', 0, 'dyskretyzacja', 0, 'PSOiter',0, ...
'PSOs',0,'PSOk',0, 'PSOp',0); 

%# read the acceptable names
optionNames = fieldnames(options);
%# count arguments
nArgs = length(varargin);
if round(nArgs/2)~=nArgs/2
   error('Program needs propertyName/propertyValue pairs')
end
i =1;
for pair = reshape(varargin,2,[])
   %checking for forbidden parameters%
   if(strcmp(options.wejscieTyp,'czyt') && ~isempty(find(ismember(czytForbiddenParams,pair{1}), 1)))
       error(strcat('Invalid parameter ',pair{1},' for wejscieTyp=czyt'));
   elseif(strcmp(options.wejscieTyp,'gen') && ~isempty(find(ismember(genForbiddenParams,pair{1}), 1)))
       error(strcat('Invalid parameter ',pair{1},' for wejscieTyp=gen'));
   end
   
   if any(strcmp(pair{1},optionNames))
      options.(pair{1}) = pair{2};
      i=i+1;
   else
      error('%s is not a recognized parameter name',inpName)
   end
end
%checking required parameters
if(isempty(options.etap) || isempty(options.wejscieTyp) ||  isempty(options.dyskretyzacja))
    error('Required parameters not found')
end
%checking parameters
if(isempty(options.dyskretyzacja) || options.dyskretyzacja <= 1)
    error('Parameter dyskretyzacja not found');
end
%still checking parameters
if(strcmp(options.wejscieTyp,'czyt'))
    if(isempty(options.sciezkaTrain))
        error('Parameter sciezkaTrain empty (wejscieType = czyt)');
    elseif(~isempty(options.procRozmTest) && ~isempty(options.sciezkaTest))
        error('Parameter procRozmTest is not empty (sciezkaTest exists)');
    end
elseif(strcmp(options.wejscieTyp,'gen'))
    if(options.iloscKlas < 1 || options.iloscCech < 0 || options.iloscPowtorzenWKlasie < 0 )
        error('Sth wrong with parameters');
    elseif(options.minLos>options.maxLos)
        error('minLos > maxLos');
    end
else
    error('wejscieTyp = ?');
end


filename = strcat(options.etap,'/main.m');

if ~exist(filename,'file')
    error('wrong stage name');
end

%setting global variables
isRunByTAIO  = true;
wejscieTyp = options.wejscieTyp;
sciezkaTrain = options.sciezkaTrain;
sciezkaTest = options.sciezkaTest;
sciezkaOutputKlas = options.sciezkaOutputKlas;
sciezkaOutputErr = options.sciezkaOutputErr;
iloscKlas = options.iloscKlas;
%rownolegle = options.rownolegle;
iloscCech = options.iloscCech;
iloscPowtorzenWKlasie = options.iloscPowtorzenWKlasie;
minLos = options.minLos;
maxLos = options.maxLos;
ograniczNietermin = options.ograniczNietermin;
procRozmObce = options.procRozmObce;
zaburzenie = options.zaburzenie;
procRozmTest = options.procRozmTest;
dyskretyzacja = options.dyskretyzacja;
PSOiter = options.PSOiter;
PSOs = options.PSOs;
PSOk = options.PSOk;
PSOp = options.PSOp;

try
   run(filename);
catch err
   rethrow(err); %reverting path%
end

clearvars

end

