function [W]=quasi_newton_BFGS(fun,W,x,y,xtest,ytest,par,task)
% HOMEWROK 6, NICOLO POLLINI 926876996 nicolo@campus.technion.ac.il (May 2016)
nvars=length(W);

[f,g]=fun(W,x,y,par,task);

maxiter=2000;
iter=1;
ftest=zeros(2000,1);
ftest(iter)=fun(W,xtest,ytest,par,'test');
fplot=zeros(2000,1);
fplot(iter)=f;

%% PRINT STARTING POINT
    fprintf(' Iter:%3i  f(x):%4.5f  step_size:%2.3f  norm_g.:%3.6f \n',iter,f,0,norm(g));
%% Find optimum
B=eye(size(nvars));
d=-B*g;
while norm(g) >= 1e-4
    
 
    [alpha]=armijorule(fun,W,x,y,g,d,par,task);

    Wold=W;
    W=Wold+alpha*d;
    gold=g;
    [f,g]=fun(W,x,y,par,task);
    
    if gold'*d < g'*d
           p=W-Wold; %vector
           q=g-gold; %vector
           s=B*q; %vector 
           u=p'*q; %scalar
           t=s'*q;%scalar
           v=p/u-s/t;
           B = B + (p*p')/u - (s*s')/t + t*(v*v'); %BFGS update of approx. of H^-1 
    end
    d=-B*g;

    % Training error
    fplot(iter)=f;

    % Test error
    ftest(iter)=fun(W,xtest,ytest,par,'test');
    %% PRINT RESULTS
    fprintf(' Iter:%3i  f(x):%4.5f  step_size:%2.3f  norm_g.:%3.6f \n',iter,f,max(abs(W-Wold)),norm(g));
    
    iter=iter+1;
    if iter==maxiter
        break
    end
end
 

fopt_train=fun(W,x,y,par,task)
fopt_test=fun(W,xtest,ytest,par,'test')

%% Plot training error
figure(12)
hold on
title('Training & testing error curves')
plot([1:1:iter],log10(fplot(1:iter)-fopt_train),[1:1:iter],log10(ftest(1:iter)-fopt_test))
ax=gca;
set(ax,'XTick',[1:150:iter])
xlabel('Iter')
ylabel('log_{10}[f(x_{k})-p^{*}]')
legend('Train Error','Test Error')
drawnow

% %% Plot testing error
% figure(13)
% hold on
% title('Test error curve')
% plot([1:1:iter],log10(ftest(1:iter)-fopt_test))
% ax=gca;
% set(ax,'XTick',[1:150:iter])
% xlabel('Iter')
% ylabel('log_{10}[f(x_{k})-p^{*}]')
% drawnow

