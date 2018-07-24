function [alpha]=armijorule(fun,W,x,y,g,d,par,task)
% HOMEWROK 4, NICOLO POLLINI 926876996 nicolo@campus.technion.ac.il (May 2016)

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