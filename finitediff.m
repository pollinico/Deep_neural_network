function [gnum]=finitediff(W,x,par)

[y]=myfunction(x);
epsmio=1e-7;
n=length(W);
%% First derivative g
gnum=zeros(n,1);
e=zeros(n,1);
for i=1:n
    e(i)=1;
    gnum(i)=((myDNNapprox(W+epsmio*e,x,par)-y)^2-(myDNNapprox(W-epsmio*e,x,par)-y)^2)/(2*epsmio);
    e=zeros(n,1);
end