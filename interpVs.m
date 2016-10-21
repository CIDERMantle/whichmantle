function varargout=interpVs(mycase)
% []=INTERPVS()
%
% Accept a predicted Vs grid and reinterpolate it using Generic 
% Mapping Tools so we can compare with the observations from Colorado
%
% INPUT:     
% 
% mycase      The case that you are going to run. This is interpreted as
%               the filename (e.g. Vs_all_T2g1)
%            
% OUTPUT:
%
%
%
% NOTES:   
% We know the predicted data are 0.2 degrees spacing and the observed data
% are 0.25 degrees spacing. We want to interpolate the observed data to the
% smaller grid of the predicted data
% They both have the same areal extents, which will be -R244/257/31/44
%
% SEE ALSO:  
% Last modified by charig-at-email.arizona.edu on 10/21/2016

defval('delz',[(5000:2000:197000),(200000:5000:400000)]);
defval('R','-R244/257/31/44');
defval('haveNans',0);
defval('dx',66);
defval('dy',66);
defval('lonp',reshape([244:0.2:257]',dy,1);
defval('latp',gamini([31:0.2:44],dx));

% Add the path to the gmt functions
setenv('PATH',[getenv('PATH') ':' '/usr/local/bin'])

% Get the path to the data files
defval('ddir1',fullfile('Data'));

% Get and load the predicted data file
fnpl1=sprintf('%s/%s.mat',ddir1,'mycase');
load fnpl1
% The data is saved as the variable Vs_all

% Load the location of NaNs from the LAB depth data set if we have it
fnpl2=sprintf('%s/%s.mat',ddir1,'NanDepth');
if exist(fnpl2,'file')==2 
  load NanDepth.mat
  haveNans = 1;
end

% Preallocate
newlon = nan(dx,dy,length(delz));
newlat = nan(dx,dy,length(delz));
newVsObs = nan(dx,dy,length(delz));
predlon = nan(dx,dy,length(delz));
predlat = nan(dx,dy,length(delz));
predVs = nan(dx,dy,length(delz));

% Loop over the depth slices we have
for d = 1:length(delz)
    
    disp('Layer: ')
    d
        
    % Make a matrix we can output to ascii for gmt
    mygrid = [lonobsIntF(:,d) latobsIntF(:,d) Vs_obsIntF(:,d)];
    save('tempgrid1.txt','-ascii','mygrid');
    
    % Make a grid in GMT
    system(['gmt xyz2grd tempgrid1.txt -Gtempgrid1.grd -I0.25 ' R ]);
    
    % Sample to the finer grid in GMT
    system(['gmt grdsample tempgrid1.grd -Gtempgrid2.grd -I0.2 ' R ]);
    
    % Go to ascii using GMT
    system(['gmt grd2xyz tempgrid2.grd > tempgrid3.txt']);
    
    % Read back into MATLAB
    temp1 = load('tempgrid3.txt');
    
    % Reshape to matrices
    newlon(:,:,d) = reshape(temp1(:,1),dx,dy)';
    newlat(:,:,d) = reshape(temp1(:,2),dx,dy)';
    newVsObs(:,:,d) = reshape(temp1(:,3),dx,dy)';
    
    % Enforce a NaN where we should have one from the LAB depth dataset
    if haveNans
      VsInt(:,d) = VsInt(:,d).*~NanDepth;
      VsInt(find(NanDepth==1),d) = NaN;
    end
    

    % Reshape the predicted files
    predlon(:,:,d) = (reshape(lonp,66,66)+360)';
    predlat(:,:,d) = flipud(reshape(latp,66,66)');
    predVs(:,:,d) = flipud(reshape(VsInt(:,d),66,66)');
    
 
end

% From here you can do
% newlon - predlon
% newlat - predlat
% newVsObs(:,:,13) - predVs(:,:,13)



