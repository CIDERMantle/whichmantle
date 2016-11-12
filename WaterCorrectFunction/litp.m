% %%%%%%%%%%%%%%%%%%%%%%
% CIDER mantle group
% litp - lithosthatic pressure 
% h - depth in m
% Last updated: Shi Sim 11 November 2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%

function p = litp(h)
rho = 3300;     % kg/m3 density of peridotite (ref?)
g = 9.81;       % m/s gravity
p = - rho .*g.* h;