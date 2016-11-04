% function Q to calculate the seismic wave attenuation which is a function
% of frequency and T,P and chemical parameters that specifies the chemical
% environment (such as water fugacity)

%  right now, we only set up one variable which is C as water
% fugacity, T is given in "correctwater.m"
% 

function Q = Qinv(C,T,Tmelt)
   w = 1; % Hz, when calculating geothermal
   beta = 25;
   
%    % plate model
%    % alpha = 0.1;
%    if(alpha == 0.1)
%        A=2.4e-7; % Hz
%        B=A;
%        
%    end
%    if(alpha==0.2)
%        A = 6.7e2;
%        B=A;
%    end
%    if(alpha == 0.3)
%       A=9.0e5;
%       B=A;
%    end
   
     % cooling half-space model
   % alpha = 0.1;
   if(alpha == 0.1)
       A=7.3e-6; % Hz
       B=A;
       
   end
   if(alpha==0.2)
       A = 9.7e3;
       B=A;
   end
   if(alpha == 0.3)
      A=8.8e6;
      B=A;
   end 


Q = ((A+B*C)/w)^alpha*exp((-alpha)*beta*(Tmelt/T));

return
