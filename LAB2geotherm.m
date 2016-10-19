function varargout=LAB2geotherm(labdepth)
% [thedates,PGRt,PGRtU,PGRtL]=LAB2GEOTHERM(labdepth)
%
% This function accepts a depth to the LAB that you have perhaps 
% from seismic observations and returns a synthetic geotherm made 
% from half space cooling theory  where the boundary layer 
% depth corresponds to the depth you requested.
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
% SEE ALSO:  
% Last modified by charig-at-email.arizona.edu on 10/19/2016

defval('labdepth',50000);
defval('theages',[0:1:150]);

if ~isstr(labdepth)

%%%
% INITIALIZATION
%%%

% Do we have the lookup table saved already?
% Directory
defval('ddir1',fullfile('Data'));
% And the appropriate name
fnpl=sprintf('%s/%s.mat',ddir1,'labdepth2age');

if exist(fnpl,'file')==2
    % We have a file, just load it
    load(fnpl)
    disp(sprintf('Loading %s',fnpl))
else
    % Make a new one

    % Get the file which has the Temperature data from a half space
    % cooling model
    fnpl2=sprintf('%s/Tsafe.mat',ddir1);
    % Load it
    load(fnpl2)
    Tsafe=Tsafe';

    % Get the file with depth information in it
    fnpl3=sprintf('%s/delz.mat',ddir1);
    % Load it
    load(fnpl3)
    
    % If you don't have it try this
    %defval('delz',[(5000:2000:197000),(200000:5000:400000)]);
    
    % Loop over the possible ages of oceanic lithosphere
    for i=2:151
      % Tsafe column 1 is time, column 2 is temperature

      % Grab the part that is in the mantle
      indeks1 = Tsafe(i,:)>1650;
      % Make a line from it
      P1 = polyfit(Tsafe(i,indeks1),delz(indeks1),1);
      Yfit1 = polyval(P1,[800:100:1800]);

      % Grab the part that is in the lithosphere
      indeks2 = Tsafe(i,:)<1450;
      % Make a line from it
      P2 = polyfit(Tsafe(i,indeks2),delz(indeks2),1);
      Yfit2 = polyval(P2,[800:100:1800]);

% Test
% clf
% plot(Tsafe(2,:),delz/1000)
% hold on
% plot([800:100:1800],Yfit1/1000)
% plot([800:100:1800],Yfit2/1000)

      % Find the intersection of these two lines
      [XI,YI] = polyxpoly([800:100:1800],Yfit1,[800:100:1800],Yfit2);
       
      % These are the depths associated with each HSC model of age
      thedepths(i) = YI;

      % Save this as a lookup table so we don't have to do it again
      save(fnpl,'thedepths','theages')
    end

end
    
% We want 'labdepth'
[val,Ind] = min(abs(thedepths-labdepth));

myage=theages(Ind);

varns={myage};
varargout=varns(1:nargout);

elseif strcmp(res,'demo1')
    % Load some seismic LAB depth data
   LABdata = load('figures/figdata/LekicFischer_noheader.txt');
   [n,m] = size(LABdata);

   for j=1:n
     theages(j) = LAB2geotherm(LABdata(j,3)*1000);
   end
   agegrid = [LABdata(:,1) LABdata(:,2) theages']; 
   
   save('Data/agegrid.mat','agegrid')
    
end

