%
%
%
% Last modified by charig-at-email.arizona.edu on 11/18/2016
%
%
% Here is the list of data files
% T1g1 PotTemp 1350 C  Grainsize 1e-2
% T1g2 PotTemp 1350 C  Grainsize 1e-3
% T1g3 PotTemp 1350 C  Grainsize 1e-4
% T2g1 PotTemp 1450 C  Grainsize 1e-2
% T2g2 PotTemp 1450 C  Grainsize 1e-3
% T2g3 PotTemp 1450 C  Grainsize 1e-4
% T3g1 PotTemp 1550 C  Grainsize 1e-2
% T3g2 PotTemp 1550 C  Grainsize 1e-3
% T3g3 PotTemp 1550 C  Grainsize 1e-4
% T1150g1 PotTemp 1150 C  Grainsize 1e-2
% T1150g2 PotTemp 1150 C  Grainsize 1e-3
% T1150g3 PotTemp 1150 C  Grainsize 1e-4
% T1250g1 PotTemp 1250 C  Grainsize 1e-2
% T1250g2 PotTemp 1250 C  Grainsize 1e-3
% T1250g3 PotTemp 1250 C  Grainsize 1e-4
mycase = {'T1g1' 'T1g2' 'T1g3'...
    'T2g1' 'T2g2' 'T2g3'...
    'T3g1' 'T3g2' 'T3g3'...
    'T1150g1' 'T1150g2' 'T1150g3'...
    'T1250g1' 'T1250g2' 'T1250g3'};
thetemps = [1350 1350 1350 1450 1450 1450 1550 1550 1550 1150 1150 1150 1250 1250 1250];
    
thegrains = [1e-2 1e-3 1e-4 1e-2 1e-3 1e-4 1e-2 1e-3 1e-4 1e-2 1e-3 1e-4 1e-2 1e-3 1e-4];

% Here we would call the script to read the Vsv observations and
% interpolate to evenly spaced depths
% (This data stored elsewhere because its large)
%Interpolate_Vsv_Observation

% Now interpolate horizontally to match the predicted data
%interpVs

%%%
% Each of the above scripts create save files, so we can just load them
%%%

mydepth=25; %70km

% Now load the observed data
load('Data/finalObsVs.mat')
VsO = squeeze(newVsObs(:,:,mydepth)).*1000;
% The data are in the matrix "newVsObs"

%mycase='T1150g3';
for i = 1:length(mycase)

% Now load one of the prediction cases
load(['Data/Vs_all_' mycase{i} '.mat'])
% This data is stored as "Vs_all"

load('Data/delz.mat')
load('Data/NanDepth.mat')

% Here is the part about NaNs
% The two statements should be the same
%temp1 = find(Vs_all(:,10)==min(min(Vs_all(:,10))));
temp2 = find(NanDepth==1);
% But formally set the NaNs anyway
Vs_all(temp2,:) = NaN;


% Lets grab one depth (and reshape) to take a look
defval('dx',66);
defval('dy',66);
defval('lonp',repmat([244:0.2:257]',dy,1));
defval('latp',gamini([31:0.2:44],dx)');

VsP = Vs_all(:,mydepth);
VsP = flipud(reshape(VsP,dx,dy)');
% % Quick figs
% figure
% imagesc(VsP)
% caxis([4200 4800])
% title('Predicted')
% figure
% % Go to m/s
% VsO = newVsObs(:,:,15)*1000;
% imagesc(VsO)
% caxis([4200 4800])
% title('Observed')



% Lets make a statistic for the comparison
rmse(i) = sqrt(nansum((VsO(:) - VsP(:)).^2))/length(VsO(:));

% % Image the resisuals
% figure 
% imagesc(VsO - VsP)
% caxis([-500 500])
% title('Residuals')
% 
% % Skew plot the residuals
% figure
% plot(VsP(:),VsO(:),'.')
% xlim([4100 4800])
% ylim([4100 4800])

load('Data/wus_provinces_ll')
%coast = load('coast');
% Combined figure
figure('position',[1 1 800 800])
subplot(2,2,1)
% Parallels = lattitude
% Meridians = longitude
axesm('mercator','MapLatLimit',[31 44],'MapLonLimit',[244 257],...
    'MLineLocation',[4],'PLineLocation',[2],'MeridianLabel','on','ParallelLabel','on',...
    'MLabelParallel','south')
framem on; gridm on; tightmap;
mydata = VsO;
[m,n]=size(mydata);
indeks1 = flipud(reshape(lonp,dx,dy)');
indeks2 = flipud(reshape(latp,dx,dy)');
geoshow(indeks2,indeks1,mydata,'DisplayType','texturemap')
crange=[4000 4800];
caxis(crange);
kelicol(1)
hold on
%geoshow(coast.lat,coast.long,'DisplayType','line')
plotm(wus_provinces_ll(:,1),wus_provinces_ll(:,2),'w','LineWidth',1.5)
title('Observed Vs')
colorbar





subplot(2,2,2)
axesm('mercator','MapLatLimit',[31 44],'MapLonLimit',[244 257],...
    'MLineLocation',[4],'PLineLocation',[2],'MeridianLabel','on','ParallelLabel','on',...
    'MLabelParallel','south')
framem on; gridm on; tightmap;
mydata = VsP;
[m,n]=size(mydata);
indeks1 = flipud(reshape(lonp,dx,dy)');
indeks2 = flipud(reshape(latp,dx,dy)');
geoshow(indeks2,indeks1,mydata,'DisplayType','texturemap')
crange=[4000 4800];
caxis(crange);
kelicol(1)
hold on
%geoshow(coast.lat,coast.long,'DisplayType','line')
plotm(wus_provinces_ll(:,1),wus_provinces_ll(:,2),'w','LineWidth',1.5)
title(['Predicted Vs, case:' mycase{i}])
colorbar

%imagesc(VsP)
%caxis([4200 4800])
%title(['Predicted Vs, case:' mycase])
%colorbar

subplot(2,2,3)
axesm('mercator','MapLatLimit',[31 44],'MapLonLimit',[244 257],...
    'MLineLocation',[4],'PLineLocation',[2],'MeridianLabel','on','ParallelLabel','on',...
    'MLabelParallel','south')
framem on; gridm on; tightmap;
mydata = VsO - VsP;
[m,n]=size(mydata);
indeks1 = flipud(reshape(lonp,dx,dy)');
indeks2 = flipud(reshape(latp,dx,dy)');
geoshow(indeks2,indeks1,mydata,'DisplayType','texturemap')
crange=[-500 500];
caxis(crange);
kelicol(1)
hold on
%geoshow(coast.lat,coast.long,'DisplayType','line')
plotm(wus_provinces_ll(:,1),wus_provinces_ll(:,2),'w','LineWidth',1.5)
title('Residuals (Obs - Pred)')
colorbar

%imagesc(VsO - VsP)
%caxis([-500 500])
%title('Residuals')
%colorbar

subplot(2,2,4)
plot(VsP(:),VsO(:),'.')
xlim([4000 4800])
ylim([4000 4800])
xlabel('Predicted values');
ylabel('Observed values');
set(gca, 'XTick', [4000 4200 4400 4600 4800])
set(gca, 'YTick', [4000 4200 4400 4600 4800])

title('Skew plot of the residuals')
axis square
grid on
saveas(gcf,['figures/' mycase{i} '_'  num2str(delz(mydepth)) '_fig.png'])

end

save('Data/theRMSEs.mat','mycase','rmse')

% Figure of the RMSE
figure
scatter(thetemps,thegrains,200,rmse,'filled')
set(gca,'yscale','log')
colorbar
xlabel('Potential Temperature')
ylabel('Grainsize')
title('rmse of cases')
saveas(gcf,['figures/rmse_' num2str(delz(mydepth)) '_fig.png'])



