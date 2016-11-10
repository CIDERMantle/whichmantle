% %%%%%%%%%%%%%%%%%
% 
% Cider mantle: to interp/extrap to get the same depth slices for Vs obs. 
% 
% Last modified by shsim-at-ucsd.edu on 10/25/2016
% Last modified by charig-at-email.arizona.edu on 10/26/2016 
%
% %%%%%%%%%%%%%%%%%

function varargout = interpVsdepth(mycase);

load(['../OldData/' mycase '.mat'])

for i = 1:4356
vsnew(i,:) = interp1([5000:2000:197000 200000 205000],Vs_all(i,1:99),0:5000:200000,'linear','extrap');
end

Vs_all = vsnew;

save([mycase '.mat'],'Vs_all')
