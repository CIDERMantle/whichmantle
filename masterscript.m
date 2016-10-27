%
%
%
%
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



