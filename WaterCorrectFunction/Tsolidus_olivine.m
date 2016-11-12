% %%%%%%%%%%%%%%%%%%%%%%
% CIDER mantle group
% Generate Tsolidus plot
% Last updated: Shi Sim 11 November 2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%


h = linspace(0,100,51);
Tsolidus = Tm_Olivine(-h*1000);

figure
plot(Tsolidus,-h)
xlabel('Temperature (Deg C)');
ylabel('Depth (km)');
title('Anhydrous Lherzolite solidus (Hirschmann 2000)')