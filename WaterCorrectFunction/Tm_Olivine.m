% %%%%%%%%%%%%%%%%%%%%%%
% CIDER mantle group
% Tsolidus - melting temperature for anhydrous lherzolite based on Hirschmann 2000
% litp - lithosthatic pressure 
% h in m
% Last updated: Shi Sim 11 November 2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%

function Tsolidus = Tm_Olivine(h) % output in deg C
a1 = 1085.7; a2 = 132.9; a3 = -5.1; % deg C
p = litp(h)*(1.e-9); % get lithostatic pressure in GPa
Tsolidus = (a1 + a2.*p + a3.*p.*p) ; 