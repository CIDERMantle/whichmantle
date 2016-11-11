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
a = -8 .* GUR.^2 ;
b = rho^2 .* vs.^4 ;
c = 4 .* GUR .* rho .* vs.^2 ;
d = rho^(3/2) .* vs.^3 .* sqrt(8*GUR + rho .* vs.^2);
nu_d = 2 * omega * sqrt(2);
nu = sqrt(a+b+c+d) ./ nu_d;
nu_melt = 2*nu./3;

if melt_indicator == 1
    denom = 2*(GUR.^2 + omega.^2 * nu_melt.^2);
    numer = rho .* (GUR + sqrt(GUR^2 + omega^2 * nu_melt.^2));
    vs_cor = sqrt(denom./numer)

else
	vs_cor = vs
end

%% MAKE A PLOT OF HOW THIS EFFECTS VS 
%% Shows the magnitude of correction
