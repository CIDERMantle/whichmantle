close all;
clc;
clear all;

Tpo = [1350,1450,1550];
Tindex = 1;
gsindex = 1;
Ch20 = 100; % ppm H/Si
load('../Data/delz.mat');
load(['../Data/Vs_all_T',num2str(Tindex),'g',num2str(gsindex),'.mat']);
% Now load the observed data
load('../Data/finalObsVs.mat')

dist = 1250000; % related with age
Tp = Tpo(Tindex);
%Tp = 1623-100; % mantle potential temperature for geotherm, K
dk = -delz(2:length(delz))/1000; lz = length(delz);
% Period
% as a function of depth for surface waves(Forsyth, Geophys. Mon.,71,1992)
period = 3*delz/4200;
% fixed period for body waves
%period = ones(1,length(delz))*10;
omega = 2*pi./period;
kappa = 1E-6;
Tad = Tead(delz,Tp);
% add conductive cooling
vel = 0.05/(60*60*24*365); age = (dist/vel)/(60*60*24*365*1E6);
Te = 273 + (Tad - 273) .* erf(delz/(2*sqrt(kappa*dist/vel))); % Te is the geotherm. half-space cooling

% figure shows the relationship between depth and temperature
figure;
plot(Te, delz./1000,'r*');
xlabel('Temperature');
ylabel('Depth(km)');
title(['Relationship between Depth and Temperature [Mantle Potential Temperature =',num2str(Tp)]);

% melting temperature 
Tmelt = 1200; % melting temperature of olivine

[nlonlat,ndep] = size(Vs_all);
vs_cor = zeros(nlonlat,ndep);
for i = 1:lz
    vs_cor(:,i) = correctwater(Vs_all(:,i),Ch20,Te(i),Tmelt); % correction with prediction
end

% vs_cor is the predicted vs after water effect correction

% Lets grab one depth (and reshape) to take a look
defval('dx',66);
defval('dy',66);
defval('lonp',repmat([244:0.2:257]',dy,1));
defval('latp',gamini([31:0.2:44],dx)');

VsP = Vs_all(:,25); % for one depth
VsP1 = flipud(reshape(VsP,dx,dy)');

VsPcor = vs_cor(:,25);
VsPcor1 = flipud(reshape(VsPcor,dx,dy)');

% figure shows the comparison between original predicted Vs and predicted
% Vs after water effect correction
figure;
subplot(1,3,1);
imagesc(VsP1)
caxis([4200 4800])
title(['Predicted Vs for Depth=',num2str(delz(25))]);
colorbar;

subplot(1,3,2);
imagesc(VsPcor1)
%caxis([4200 4800])
title(['Predicted Vs After Water Correction for depth = ',num2str(delz(25))]);
colorbar;

subplot(1,3,3);
VsO1 = newVsObs(:,:,25)*1000;
imagesc(VsO1)
caxis([4200 4800])
title(['Observed Vs for depth = ',num2str(delz(25))])
colorbar;

% Image the resisuals
Dif1 = VsP1-VsPcor1;
figure 
imagesc(Dif1);
%caxis([-500 500])
title(['Magnitude of correction due to water effect from predicted Vs for depth =',num2str(delz(25))]);
colorbar;

%figure shows the relationship between the magnitude of correction and
%predicted Vs for all depths
figure;
subplot(1,2,1)
plot(VsP1(:),Dif1(:),'b*');
xlabel('Org Prediction Vs (m/s)');
ylabel('Magnitude of Correction for Vs (m/s)');
title(['Predicted Vs Before Water Correction versus Magnitude of Vs Correction due to Water effect [Temperature =',num2str(Tp),']']);

% figure shows the magnitude of correction dueto water effect
% and temperature
subplot(1,2,2);
for j = 1:nlonlat
Dif11 = Vs_all(j,:)-vs_cor(j,:); % for depths
plot(Te,Dif11,'r*' );
hold on;
end
xlabel('Temperature');
ylabel('Magnitude of Correction for Vs (m/s)');
title(['Temperature (related with depth) Vs Magnitude of Correction [Temperature =',num2str(Tp),']']);



