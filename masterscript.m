%
%
%
% Last modified by charig-at-email.arizona.edu on 10/26/2016
%
%


% Here we would call the script to read the Vsv observations and
% interpolate to evenly spaced depths
% (This data stored elsewhere because its large)
%Interpolate_Vsv_Observation

% Now interpolate horizontally to match the predicted data
%interpVs

%%%
% Each of the above scripts create save files, so we can just load them
%%%

% Now load the observed data
load('Data/finalObsVs.mat')
% The data are in the matrix "newVsObs"

% Now load one of the prediction cases
load('Data/Vs_all_T1g1.mat')
% This data is stored as "Vs_all"

% Lets grab one depth (and reshape) to take a look
defval('dx',66);
defval('dy',66);
defval('lonp',repmat([244:0.2:257]',dy,1));
defval('latp',gamini([31:0.2:44],dx)');

VsP = Vs_all(:,25);
VsP = flipud(reshape(VsP,dx,dy)');
% Quick figs
figure
imagesc(VsP)
caxis([4200 4800])
title('Predicted')
figure
% Go to m/s
VsO = newVsObs(:,:,25)*1000;
imagesc(VsO)
caxis([4200 4800])
title('Observed')



% Lets make a statistic for the comparison
rmse = sqrt(nansum((VsO(:) - VsP(:)).^2))/length(VsO(:))

% Image the resisuals
figure 
imagesc(VsO - VsP)
caxis([-500 500])
title('Residuals')

% Skew plot the residuals
figure
plot(VsP(:),VsO(:),'.')
xlim([4100 4800])
ylim([4100 4800])
