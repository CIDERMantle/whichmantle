function varargout=LAB2geotherm(labdepth)
% [thedates,PGRt,PGRtU,PGRtL]=LAB2GEOTHERM(labdepth)
%
% This function accepts a depth to the LAB that you have and returns a
% geotherm where the boundary layer depth corresponds to the depth you
% requested.
%
% INPUT:
%
% labdepth     
%
%            
% OUTPUT:
%
% thedates      Your dates back to you.
%
%
% NOTES:   
%
% SEE ALSO:  PLM2POT
% Last modified by charig-at-princeton.edu on 9/03/2014

%defval('TH',{'greenland' 0.5});
%defval('L',60);
%defval('phi',0);
%defval('theta',0);
defval('labdepth',50000);

%%%
% INITIALIZATION
%%%

% Top level directory
% For Chris
%IFILES=getenv('IFILES');
%clear all

% Do we have the lookup table saved already?
% Directory
defval('ddir1',fullfile('~/','Research','CIDER','data'));
% And the appropriate name
fnpl=sprintf('%s/%s.mat',ddir1,'labdepth2age');

if exist(fnpl,'file')==2
    load(fnpl)
    disp(sprintf('Loading %s',fnpl))
else
    % Make a new one

    % Read the file
    fnpl2=sprintf('%s/Tsafe.mat','data');

    % Load it
    load(fnpl2)

    delz = [(5000:2000:197000),(200000:5000:400000)];
    theages = [0:1:150];
    Tsafe=Tsafe';

    for i=2:151
    % Tsafe column 1 is time, column 2 is temperature

    % Grab the part that is in the mantle
    indeks1 = Tsafe(i,:)>1650;

    P1 = polyfit(Tsafe(i,indeks1),delz(indeks1),1);
    Yfit1 = polyval(P1,[800:100:1800]);

    % Grab the part that is in the lithosphere
    indeks2 = Tsafe(i,:)<1450;

    P2 = polyfit(Tsafe(i,indeks2),delz(indeks2),1);
    Yfit2 = polyval(P2,[800:100:1800]);

% Test
% clf
% plot(Tsafe(2,:),delz/1000)
% hold on
% plot([800:100:1800],Yfit1/1000)
% plot([800:100:1800],Yfit2/1000)


    [XI,YI] = polyxpoly([800:100:1800],Yfit1,[800:100:1800],Yfit2);

    thedepths(i) = YI;

    save(fnpl,'thedepths','theages')
    end

end
    
% We want 'labdepth'
[val,Ind] = min(abs(thedepths-labdepth));

myage=theages(Ind);

varns={myage};
varargout=varns(1:nargout);

