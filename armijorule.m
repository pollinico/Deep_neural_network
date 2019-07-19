function [alpha]=armijorule(fun,W,x,y,g,d,par,task)

%  Nicolo Pollini nicolo@campus.technion.ac.il, 
%  Technion - Israel Institute of Technology, Haifa July 2016
% Disclaimer:                                                             %
% The author reserves all rights but does not guarantee that the code is  %
% free from errors. Furthermore, the author shall not be liable in any    %
% event caused by the use of the program. 

s=1;
sigma_armijo=0.25;
beta_armijo=0.5;
alpha=s;

c=g'*d;


while fun(W+alpha*d,x,y,par,task)-fun(W,x,y,par,task)>sigma_armijo*c*alpha
    
    alpha=beta_armijo*alpha;
    if alpha<=1e-3
        break
    end
end
