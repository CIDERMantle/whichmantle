function [vs_cor] = correctmelt(vs,melt_indicator)
%calculate the correction for melt in the mantle
% This uses the notional sense of melt as an on/off switch for viscosity from
% Kohlstedt, 1992, where we can assume at least 3% melt will reduce viscosity by
% threefold. 
% GUR = 66.5; anharmonic modulus, at reference value in Ulli's code
% rho = 3310; reference density
% omega = 2*pi*100; reference frequence, just a reasonable power in earthquake spectrum

omega = 2*pi*100; rho = 3310; GUR = 66.5e+6;

% solve for initial viscosity using reference values
% This assumes a spring and dashpot model of shearwave propagation
y = sqrt(8*GUR^2-rho^(3/2) * vs^3 * sqrt(8*GUR+rho*vs^2)+(rho^2)*(vs^4)+4*GUR*rho*vs^2)/(2 * sqrt(2));
nu = y/(omega^2);
nu_melt = nu/3;

if melt_indicator == 1
	denom = 2 *(GUR^2 + omega^2 * nu_melt^2)
	numer = rho * (GUR + sqrt(GUR^2 + omega^2 * nu_melt^2))
	vs_cor = denom/numer

else
	vs_cor = vs


