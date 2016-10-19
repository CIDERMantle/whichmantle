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




% Add the path to the gmt functions
setenv('PATH',[getenv('PATH') ':' '/usr/local/bin'])

% Load the predicted data
load Vsv_Prediction.mat

% Load the observed data
load Vs_observation_DepthInt.mat

% Load the location of NaNs from the LAB depth data set
load NanDepth.mat

% We know the predicted data are 0.2 degrees spacing and the observed data
% are 0.25 degrees spacing. We want to interpolate the observed data to the
% smaller grid of the predicted data
% They both have the same areal extents, which will be -R244/257/31/44

% Preallocated some shit
newlon = nan(66,66,41);
newlat = nan(66,66,41);
newVsObs = nan(66,66,41);
predlon = nan(66,66,41);
predlat = nan(66,66,41);
predVs = nan(66,66,41);

for d = 1:41 % the depth slices we have
    
    disp('Layer: ')
    d
    
    % Set some GMT variables
    R = '-R244/257/31/44';
    
    % Make a matrix we can output to ascii for gmt
    mygrid = [lonobsIntF(:,d) latobsIntF(:,d) Vs_obsIntF(:,d)];
    save('tempgrid1.txt','-ascii','mygrid');
    
    % Make a grid
    system(['gmt xyz2grd tempgrid1.txt -Gtempgrid1.grd -I0.25 ' R ]);
    
    % Sample to the finer grid
    system(['gmt grdsample tempgrid1.grd -Gtempgrid2.grd -I0.2 ' R ]);
    
    % Go to ascii
    system(['gmt grd2xyz tempgrid2.grd > tempgrid3.txt']);
    
    % Read back into MATLAB
    temp1 = load('tempgrid3.txt');
    
    newlon(:,:,d) = reshape(temp1(:,1),66,66)';
    newlat(:,:,d) = reshape(temp1(:,2),66,66)';
    newVsObs(:,:,d) = reshape(temp1(:,3),66,66)';
    
    % Enforce a NaN where we should have one from the LAB depth dataset
    VsInt(:,d) = VsInt(:,d).*~NanDepth;
    VsInt(find(NanDepth==1),d) = NaN;

    % Reshape the predicted files
    predlon(:,:,d) = (reshape(lonp,66,66)+360)';
    predlat(:,:,d) = flipud(reshape(latp,66,66)');
    predVs(:,:,d) = flipud(reshape(VsInt(:,d),66,66)');
    
 
end

% From here you can do
% newlon - predlon
% newlat - predlat
% newVsObs(:,:,13) - predVs(:,:,13)

keyboard


