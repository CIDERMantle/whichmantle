% %%%%%%%%%%%%%%%%%
% 
% Cider mantle: to interp/extrap to get the same depth slices for Vs obs. 
% 
% %%%%%%%%%%%%%%%%%

function vsnew = interpVsdepth(Vs_all);
for i = 1:4356
vsnew(i,:) = interp1([5000:2000:197000 200000 205000],Vs_all(i,1:99),0:5000:200000,'linear','extrap');
end