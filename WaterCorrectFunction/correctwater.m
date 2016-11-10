% water effect function
% only concern is that the parameters that we use to correct the water
% fugacity effect from the previous seismic shear velocity. 

% reference: S.-i Karato et al. 1998, Q at water-free conditions and at
% water-rich conditions become comparable when Ch20 = 1 ppm H/Si,and the
% addition of ~100 ppm H/Si of water content enhances dislocation mobility
% by a factor of ~100, which implies a factor of ~(100)^alpha increase in Q

% based on this reference, the amount of melting produced in the certain
% depth is controlled by the water content.
% Figure 3 in this paper shows
% the water content in olivine and degree of melting as a function of depth
% beneath in the different source region.

function vs_cor = correctwater(vs,Ch20,T,Tmelt)
% cooling half-space model
% vs is the seismic wave velocity as a function of temperature and pressure
% when only anharmonic.
% T stands for the absolute temperature corresponding to specific
% interested depth in the geotherms of the upper mantle in cooling
% half-space model,
% T can be calculated for each specific depth and each specific age of the oceanic lithosphere in Uli's
% codes (VsBurg.m  variable Te)
% Ch20 is the water content, unit is ppm H/Si

alpha = 0.1;
t1 = (1/2)*cotd(90*alpha);
% right now, we only set up one variable which is C as water
% fugacity

%Tmelt = TempMelt(P); % ???melting temperature here is a function of pressure P, may just use the empirical value for the relationship between 
%melting temperature and pressure in the specific depth for specific
%mineral material, 

Q = Qinv(Ch20,T,Tmelt);
vs_cor = vs*(1-t1*Q);

return 
